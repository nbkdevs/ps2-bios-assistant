using System.Security.Cryptography;

namespace Ps2BiosChecksum;

public sealed record BiosValidation(bool Ok, string Summary, string Detail);

public sealed record BiosChecksumResult(
    long SizeBytes,
    string Md5,
    string Sha1,
    BiosValidation Validation,
    string? Path = null);

public static class BiosChecksum
{
    public static readonly long[] CommonBiosSizes =
    [
        2L * 1024 * 1024,
        4L * 1024 * 1024,
        8L * 1024 * 1024,
        16L * 1024 * 1024,
    ];

    public static string FormatFileSize(long bytes)
    {
        if (bytes < 1024) return $"{bytes} B";
        var kib = bytes / 1024.0;
        if (kib < 1024) return $"{kib:0.00} KB";
        return $"{kib / 1024.0:0.00} MB";
    }

    public static BiosValidation ValidateBiosSize(long sizeBytes)
    {
        if (sizeBytes <= 0)
        {
            return new BiosValidation(
                false,
                "File is empty",
                "An empty file cannot be used as a BIOS image. Basic check only.");
        }

        if (CommonBiosSizes.Contains(sizeBytes))
        {
            return new BiosValidation(
                true,
                "Basic checks passed",
                "Size matches a commonly reported PS2 BIOS dump size. Not proof of authenticity.");
        }

        return new BiosValidation(
            false,
            "File size does not match common BIOS sizes",
            "Common sizes are 2, 4, 8, or 16 MiB. Unexpected size may mean incomplete or non-BIOS data.");
    }

    public static BiosChecksumResult HashBytes(ReadOnlySpan<byte> data, string? path = null)
    {
        var md5 = Convert.ToHexString(MD5.HashData(data)).ToLowerInvariant();
        var sha1 = Convert.ToHexString(SHA1.HashData(data)).ToLowerInvariant();
        return new BiosChecksumResult(data.Length, md5, sha1, ValidateBiosSize(data.Length), path);
    }

    public static BiosChecksumResult HashFile(string path)
    {
        var bytes = File.ReadAllBytes(path);
        return HashBytes(bytes, path);
    }
}
