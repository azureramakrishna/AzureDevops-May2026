$connectTestResult = Test-NetConnection -ComputerName saanvikit2026.file.core.windows.net -Port 445
if ($connectTestResult.TcpTestSucceeded) {
    # Save the password so the drive will persist on reboot
    cmd.exe /C "cmdkey /add:`"saanvikit2026.file.core.windows.net`" /user:`"localhost\saanvikit2026`" /pass:`"WpY33Q2X/H+gqZ0axOu/nsb928F7+q6ow1BD000zmes/PTP8k5A/L9b7jLHidVNWc9InQhXbA13T+AStf3yXBQ==`""
    # Mount the drive
    New-PSDrive -Name Z -PSProvider FileSystem -Root "\\saanvikit2026.file.core.windows.net\saanvikit" -Persist
} else {
    Write-Error -Message "Unable to reach the Azure storage account via port 445. Check to make sure your organization or ISP is not blocking port 445, or use Azure P2S VPN, Azure S2S VPN, or Express Route to tunnel SMB traffic over a different port."
}