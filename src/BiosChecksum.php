<?php

declare(strict_types=1);

namespace AllPs2Bios\Checksum;

final class BiosChecksum
{
    /** @var list<int> */
    public const COMMON_BIOS_SIZES = [
        2 * 1024 * 1024,
        4 * 1024 * 1024,
        8 * 1024 * 1024,
        16 * 1024 * 1024,
    ];

    public static function formatFileSize(int $bytes): string
    {
        if ($bytes < 1024) {
            return $bytes . ' B';
        }
        $kib = $bytes / 1024;
        if ($kib < 1024) {
            return sprintf('%.2f KB', $kib);
        }
        return sprintf('%.2f MB', $kib / 1024);
    }

    /** @return array{ok:bool,summary:string,detail:string} */
    public static function validateBiosSize(int $sizeBytes): array
    {
        if ($sizeBytes <= 0) {
            return [
                'ok' => false,
                'summary' => 'File is empty',
                'detail' => 'An empty file cannot be used as a BIOS image. Basic check only.',
            ];
        }
        if (in_array($sizeBytes, self::COMMON_BIOS_SIZES, true)) {
            return [
                'ok' => true,
                'summary' => 'Basic checks passed',
                'detail' => 'Size matches a commonly reported PS2 BIOS dump size. Not proof of authenticity.',
            ];
        }
        return [
            'ok' => false,
            'summary' => 'File size does not match common BIOS sizes',
            'detail' => 'Common sizes are 2, 4, 8, or 16 MiB. Unexpected size may mean incomplete or non-BIOS data.',
        ];
    }

    /** @return array{sizeBytes:int,md5:string,sha1:string,validation:array{ok:bool,summary:string,detail:string},path:?string} */
    public static function hashBytes(string $data, ?string $path = null): array
    {
        return [
            'sizeBytes' => strlen($data),
            'md5' => md5($data),
            'sha1' => sha1($data),
            'validation' => self::validateBiosSize(strlen($data)),
            'path' => $path,
        ];
    }

    /** @return array{sizeBytes:int,md5:string,sha1:string,validation:array{ok:bool,summary:string,detail:string},path:?string} */
    public static function hashFile(string $path): array
    {
        $data = file_get_contents($path);
        if ($data === false) {
            throw new \RuntimeException("Couldn't read file: {$path}");
        }
        return self::hashBytes($data, $path);
    }
}
