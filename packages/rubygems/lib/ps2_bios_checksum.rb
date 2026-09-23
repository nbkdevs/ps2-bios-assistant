# frozen_string_literal: true

module Ps2BiosChecksum
  COMMON_BIOS_SIZES = [
    2 * 1024 * 1024,
    4 * 1024 * 1024,
    8 * 1024 * 1024,
    16 * 1024 * 1024
  ].freeze

  module_function

  def format_file_size(bytes)
    return "#{bytes} B" if bytes < 1024

    kib = bytes / 1024.0
    return format("%.2f KB", kib) if kib < 1024

    format("%.2f MB", kib / 1024.0)
  end

  def validate_bios_size(size_bytes)
    if size_bytes <= 0
      return {
        ok: false,
        summary: "File is empty",
        detail: "An empty file cannot be used as a BIOS image. Basic check only."
      }
    end

    if COMMON_BIOS_SIZES.include?(size_bytes)
      return {
        ok: true,
        summary: "Basic checks passed",
        detail: "Size matches a commonly reported PS2 BIOS dump size. Not proof of authenticity."
      }
    end

    {
      ok: false,
      summary: "File size does not match common BIOS sizes",
      detail: "Common sizes are 2, 4, 8, or 16 MiB. Unexpected size may mean incomplete or non-BIOS data."
    }
  end

  def hash_bytes(data, path: nil)
    require "digest"
    bytes = data.b
    {
      size_bytes: bytes.bytesize,
      md5: Digest::MD5.hexdigest(bytes),
      sha1: Digest::SHA1.hexdigest(bytes),
      validation: validate_bios_size(bytes.bytesize),
      path: path
    }
  end

  def hash_file(path)
    hash_bytes(File.binread(path), path: path)
  end
end
