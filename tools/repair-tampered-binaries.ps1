<#
.SYNOPSIS
    Restores Flutter/Android SDK binaries that an on-access scanner has wrapped.

.DESCRIPTION
    Symptoms this fixes:
      * flutter build apk  -> "Dart snapshot generator failed with exit code
        -1073741701" (0xC000007B) on target android_aot_release_android-arm
      * adb  -> exits with -1073741819 (0xC0000005) / segfault, or
        "Не удается найти ...\AdbWinApi.dll.dat"

    The scanner moves the genuine binary to "<name>.dat" and replaces it with a
    slightly larger wrapper Windows cannot load. Tell-tale sign: the wrapper has
    an ODD byte size (real PE files are effectively never odd-sized).

    This script finds every "<name>.exe.dat" / "<name>.dll.dat" pair under the
    Flutter engine cache and Android platform-tools, deletes the wrapper, and
    puts the original back.

.NOTES
    This is a WORKAROUND. The durable fix is to exclude these paths from your
    antivirus (run an elevated PowerShell):

        Add-MpPreference -ExclusionPath "C:\flutter"
        Add-MpPreference -ExclusionPath "$env:LOCALAPPDATA\Android"
        Add-MpPreference -ExclusionPath "E:\doctor"
#>

$roots = @(
    "C:\flutter\bin\cache\artifacts\engine",
    "$env:LOCALAPPDATA\Android\sdk\platform-tools"
)

$restored = 0

foreach ($root in $roots) {
    if (-not (Test-Path $root)) {
        Write-Host "skip (not found): $root" -ForegroundColor DarkGray
        continue
    }

    Get-ChildItem -Path $root -Recurse -File -Filter "*.dat" -ErrorAction SilentlyContinue |
        Where-Object { $_.Name -match '\.(exe|dll)\.dat$' } |
        ForEach-Object {
            $original = $_.FullName -replace '\.dat$', ''
            try {
                if (Test-Path $original) { Remove-Item $original -Force -ErrorAction Stop }
                Move-Item -LiteralPath $_.FullName -Destination $original -Force -ErrorAction Stop
                Write-Host ("restored: {0} ({1:N0} bytes)" -f $original, (Get-Item $original).Length) -ForegroundColor Green
                $restored++
            } catch {
                Write-Host "FAILED: $original -- $($_.Exception.Message)" -ForegroundColor Red
            }
        }
}

if ($restored -eq 0) {
    Write-Host "Nothing to repair - no wrapped binaries found." -ForegroundColor Cyan
} else {
    Write-Host "`nRestored $restored file(s). Re-run your build." -ForegroundColor Cyan
}
