//! Local PS2 BIOS checksum and basic size-check helpers.

use md5::{Digest as Md5Digest, Md5};
use sha1::{Digest as Sha1Digest, Sha1};
use std::fs;
use std::io;
use std::path::Path;

/// Common reported PS2 BIOS dump sizes in bytes.
pub const COMMON_BIOS_SIZES: [u64; 4] = [
    2 * 1024 * 1024,
    4 * 1024 * 1024,
    8 * 1024 * 1024,
    16 * 1024 * 1024,
];

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct BiosValidation {
    pub ok: bool,
    pub summary: String,
    pub detail: String,
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct BiosChecksumResult {
    pub size_bytes: u64,
    pub md5: String,
    pub sha1: String,
    pub validation: BiosValidation,
}

pub fn format_file_size(bytes: u64) -> String {
    if bytes < 1024 {
        return format!("{bytes} B");
    }
    let kib = bytes as f64 / 1024.0;
    if kib < 1024.0 {
        return format!("{kib:.2} KB");
    }
    format!("{:.2} MB", kib / 1024.0)
}

pub fn validate_bios_size(size_bytes: u64) -> BiosValidation {
    if size_bytes == 0 {
        return BiosValidation {
            ok: false,
            summary: "File is empty".into(),
            detail: "An empty file cannot be used as a BIOS image. Basic check only.".into(),
        };
    }
    if COMMON_BIOS_SIZES.contains(&size_bytes) {
        return BiosValidation {
            ok: true,
            summary: "Basic checks passed".into(),
            detail: "Size matches a commonly reported PS2 BIOS dump size. Not proof of authenticity.".into(),
        };
    }
    BiosValidation {
        ok: false,
        summary: "File size does not match common BIOS sizes".into(),
        detail: "Common sizes are 2, 4, 8, or 16 MiB. Unexpected size may mean incomplete or non-BIOS data.".into(),
    }
}

pub fn hash_bytes(data: &[u8]) -> BiosChecksumResult {
    let mut md5 = Md5::new();
    md5.update(data);
    let mut sha1 = Sha1::new();
    sha1.update(data);
    BiosChecksumResult {
        size_bytes: data.len() as u64,
        md5: format!("{:x}", md5.finalize()),
        sha1: format!("{:x}", sha1.finalize()),
        validation: validate_bios_size(data.len() as u64),
    }
}

pub fn hash_file(path: impl AsRef<Path>) -> io::Result<BiosChecksumResult> {
    let data = fs::read(path)?;
    Ok(hash_bytes(&data))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn empty_hashes() {
        let result = hash_bytes(&[]);
        assert_eq!(result.md5, "d41d8cd98f00b204e9800998ecf8427e");
        assert_eq!(result.sha1, "da39a3ee5e6b4b0d3255bfef95601890afd80709");
        assert!(!result.validation.ok);
    }
}
