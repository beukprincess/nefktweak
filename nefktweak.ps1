
# Check for administrator privileges
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "You ran script as not administrator. Some functions may not work." -ForegroundColor Yellow
}

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# ---------- COLORS ----------
$BackColor  = [System.Drawing.Color]::FromArgb(24,24,24)
$ForeColor  = [System.Drawing.Color]::White
$Accent     = [System.Drawing.Color]::FromArgb(0,122,204)

# ---------- FORM ----------
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "NEFK Tweaker"
$Form.Size = New-Object System.Drawing.Size(1000, 600)
$Form.StartPosition = "CenterScreen"
$Form.BackColor = $BackColor
$Form.ForeColor = $ForeColor
$Form.FormBorderStyle = 'FixedSingle'
$Form.MaximizeBox = $false

# ---------- TAB CONTROL ----------
$Tabs = New-Object System.Windows.Forms.TabControl
$Tabs.Size = New-Object System.Drawing.Size(970, 500)
$Tabs.Location = New-Object System.Drawing.Point(10, 10)
$Tabs.Appearance = 'FlatButtons'
$Tabs.ItemSize = New-Object System.Drawing.Size(100, 30)
$Tabs.SizeMode = 'Fixed'
$Tabs.BackColor = $BackColor
$Tabs.ForeColor = $ForeColor

# Tabs
$TabMain       = New-Object System.Windows.Forms.TabPage
$TabInterface  = New-Object System.Windows.Forms.TabPage
$TabPerformance = New-Object System.Windows.Forms.TabPage
$TabServices   = New-Object System.Windows.Forms.TabPage
$TabPrivacy    = New-Object System.Windows.Forms.TabPage
$TabSystem     = New-Object System.Windows.Forms.TabPage
$TabApps       = New-Object System.Windows.Forms.TabPage

$TabMain.Text       = "Main"
$TabInterface.Text  = "Interface"
$TabPerformance.Text= "Performance"
$TabServices.Text   = "Services"
$TabPrivacy.Text    = "Privacy"
$TabSystem.Text     = "System"
$TabApps.Text       = "Remove Apps"

# Set tab backgrounds to match dark theme
$TabMain.BackColor = $BackColor
$TabInterface.BackColor = $BackColor
$TabPerformance.BackColor = $BackColor
$TabServices.BackColor = $BackColor
$TabPrivacy.BackColor = $BackColor
$TabSystem.BackColor = $BackColor
$TabApps.BackColor = $BackColor

$Tabs.TabPages.AddRange(@($TabMain,$TabInterface,$TabPerformance,$TabServices,$TabPrivacy,$TabSystem,$TabApps))
$Form.Controls.Add($Tabs)

# ---------- MAIN TAB ----------
# Left side - Title labels
$LblTitle = New-Object System.Windows.Forms.Label
$LblTitle.Text = "NEFK Tweaker Utility"
$LblTitle.Font = New-Object System.Drawing.Font("Segoe UI", 24, [System.Drawing.FontStyle]::Bold)
$LblTitle.ForeColor = $ForeColor
$LblTitle.AutoSize = $true
$LblTitle.Location = New-Object System.Drawing.Point(50, 50)

$LblAuthor = New-Object System.Windows.Forms.Label
$LblAuthor.Text = "by Eduard Myaskovsky"
$LblAuthor.Font = New-Object System.Drawing.Font("Segoe UI", 12)
$LblAuthor.ForeColor = $ForeColor
$LblAuthor.AutoSize = $true
$LblAuthor.Location = New-Object System.Drawing.Point(50, 100)

# Right side - Gray panel
$MainPanel = New-Object System.Windows.Forms.Panel
$MainPanel.BackColor = [System.Drawing.Color]::FromArgb(64, 64, 64)  # Gray color
$MainPanel.Location = New-Object System.Drawing.Point(500, 20)
$MainPanel.Size = New-Object System.Drawing.Size(350, 380)
$MainPanel.BorderStyle = 'None'

# Checkbox for Google Chrome installation
$ChkChrome = New-Object System.Windows.Forms.CheckBox
$ChkChrome.Text = "Install Google Chrome"
$ChkChrome.ForeColor = $ForeColor
$ChkChrome.AutoSize = $true
$ChkChrome.Location = New-Object System.Drawing.Point(20, 20)
$ChkChrome.Font = New-Object System.Drawing.Font("Segoe UI", 10)

# Checkbox for AIDA64 Extreme installation
$ChkAIDA64 = New-Object System.Windows.Forms.CheckBox
$ChkAIDA64.Text = "Install AIDA64 Extreme"
$ChkAIDA64.ForeColor = $ForeColor
$ChkAIDA64.AutoSize = $true
$ChkAIDA64.Location = New-Object System.Drawing.Point(20, 45)
$ChkAIDA64.Font = New-Object System.Drawing.Font("Segoe UI", 10)

# Checkbox for Firefox installation
$ChkFirefox = New-Object System.Windows.Forms.CheckBox
$ChkFirefox.Text = "Install Firefox"
$ChkFirefox.ForeColor = $ForeColor
$ChkFirefox.AutoSize = $true
$ChkFirefox.Location = New-Object System.Drawing.Point(20, 70)
$ChkFirefox.Font = New-Object System.Drawing.Font("Segoe UI", 10)

# Checkbox for WinRAR installation
$ChkWinRAR = New-Object System.Windows.Forms.CheckBox
$ChkWinRAR.Text = "Install WinRAR"
$ChkWinRAR.ForeColor = $ForeColor
$ChkWinRAR.AutoSize = $true
$ChkWinRAR.Location = New-Object System.Drawing.Point(20, 95)
$ChkWinRAR.Font = New-Object System.Drawing.Font("Segoe UI", 10)

# Add checkboxes to panel
$MainPanel.Controls.Add($ChkChrome)
$MainPanel.Controls.Add($ChkAIDA64)
$MainPanel.Controls.Add($ChkFirefox)
$MainPanel.Controls.Add($ChkWinRAR)

# Buttons at the bottom
$BtnApply = New-Object System.Windows.Forms.Button
$BtnApply.Text = "Apply All Tweaks"
$BtnApply.Size = New-Object System.Drawing.Size(180,40)
$BtnApply.Location = New-Object System.Drawing.Point(60,420)
$BtnApply.BackColor = $Accent
$BtnApply.FlatStyle = 'Flat'
$BtnApply.ForeColor = 'White'
$BtnApply.FlatAppearance.BorderSize = 0

$BtnRevert = New-Object System.Windows.Forms.Button
$BtnRevert.Text = "Revert All Tweaks"
$BtnRevert.Size = New-Object System.Drawing.Size(180,40)
$BtnRevert.Location = New-Object System.Drawing.Point(260,420)
$BtnRevert.BackColor = [System.Drawing.Color]::DarkRed
$BtnRevert.FlatStyle = 'Flat'
$BtnRevert.ForeColor = 'White'
$BtnRevert.FlatAppearance.BorderSize = 0

$BtnLog = New-Object System.Windows.Forms.Button
$BtnLog.Text = "Open Log File"
$BtnLog.Size = New-Object System.Drawing.Size(180,40)
$BtnLog.Location = New-Object System.Drawing.Point(460,420)
$BtnLog.BackColor = [System.Drawing.Color]::Gray
$BtnLog.FlatStyle = 'Flat'
$BtnLog.ForeColor = 'White'
$BtnLog.FlatAppearance.BorderSize = 0

$BtnRestore = New-Object System.Windows.Forms.Button
$BtnRestore.Text = "Create Restore Point"
$BtnRestore.Size = New-Object System.Drawing.Size(180,40)
$BtnRestore.Location = New-Object System.Drawing.Point(660,420)
$BtnRestore.BackColor = [System.Drawing.Color]::FromArgb(40,167,69)
$BtnRestore.FlatStyle = 'Flat'
$BtnRestore.ForeColor = 'White'
$BtnRestore.FlatAppearance.BorderSize = 0

# Add all controls to Main tab
$TabMain.Controls.AddRange(@($LblTitle, $LblAuthor, $MainPanel, $BtnApply, $BtnRevert, $BtnLog, $BtnRestore))

# ---------- LOG SETUP ----------
$Desktop = [Environment]::GetFolderPath("Desktop")
$LogPath = Join-Path $Desktop "NEFK_Tweaker_Log.txt"
Function Write-Log($text) {
    $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    Add-Content -Path $LogPath -Value "[$timestamp] $text"
}

Write-Log "=== NEFK Tweaker started ==="

# ---------- CLOSE EVENT ----------
$Form.Add_FormClosing({
    $choice = [System.Windows.Forms.MessageBox]::Show(
        "Do you want to restart now to apply all changes?",
        "Restart Required",
        [System.Windows.Forms.MessageBoxButtons]::YesNo,
        [System.Windows.Forms.MessageBoxIcon]::Question
    )
    if ($choice -eq [System.Windows.Forms.DialogResult]::Yes) {
        Write-Log "User confirmed restart."
        Restart-Computer -Force
    } else {
        Write-Log "User skipped restart."
    }
})

# ---------- CHECKLIST CREATOR ----------
function New-ChecklistPanel($items, $tooltips = $null) {
    $panel = New-Object System.Windows.Forms.Panel
    $panel.Dock = 'Fill'
    $panel.BackColor = $BackColor
    $list = New-Object System.Windows.Forms.CheckedListBox
    $list.Dock = 'Top'
    $list.Height = 400
    $list.BackColor = $BackColor
    $list.ForeColor = $ForeColor
    $list.BorderStyle = 'None'
    $list.CheckOnClick = $true
    $list.Items.AddRange($items)
    
    # Create ToolTip component
    $toolTip = New-Object System.Windows.Forms.ToolTip
    $toolTip.AutomaticDelay = 500
    $toolTip.AutoPopDelay = 5000
    $toolTip.InitialDelay = 500
    $toolTip.ReshowDelay = 100
    $toolTip.IsBalloon = $false
    $toolTip.ToolTipTitle = ""
    $toolTip.ShowAlways = $true
    
    # Add tooltips to each item
    if ($null -ne $tooltips) {
        # Store tooltips in list Tag for reference
        $list.Tag = @{ Tooltips = $tooltips; ToolTip = $toolTip }
        
        # Set tooltip for the entire list control
        # We'll use MouseMove to dynamically update tooltip based on item under cursor
        $list.Add_MouseMove({
            $point = $this.PointToClient([System.Windows.Forms.Cursor]::Position)
            $index = $this.IndexFromPoint($point)
            $tag = $this.Tag
            
            if ($null -ne $tag -and $null -ne $tag.Tooltips) {
                if ($index -ge 0 -and $index -lt $tag.Tooltips.Count) {
                    # Update tooltip text for the item
                    $tag.ToolTip.SetToolTip($this, $tag.Tooltips[$index])
                } else {
                    # Clear tooltip when not over an item
                    $tag.ToolTip.SetToolTip($this, "")
                }
            }
        })
        
        $list.Add_MouseLeave({
            $tag = $this.Tag
            if ($null -ne $tag) {
                $tag.ToolTip.SetToolTip($this, "")
            }
        })
    }
    
    $btnCheckAll = New-Object System.Windows.Forms.Button
    $btnCheckAll.Text = "Check All"
    $btnCheckAll.Size = New-Object System.Drawing.Size(100,30)
    $btnCheckAll.Location = New-Object System.Drawing.Point(10,410)
    $btnCheckAll.BackColor = $Accent
    $btnCheckAll.FlatStyle = 'Flat'
    $btnCheckAll.ForeColor = 'White'
    $btnCheckAll.FlatAppearance.BorderSize = 0
    
    $btnUncheckAll = New-Object System.Windows.Forms.Button
    $btnUncheckAll.Text = "Uncheck All"
    $btnUncheckAll.Size = New-Object System.Drawing.Size(100,30)
    $btnUncheckAll.Location = New-Object System.Drawing.Point(120,410)
    $btnUncheckAll.BackColor = [System.Drawing.Color]::Gray
    $btnUncheckAll.FlatStyle = 'Flat'
    $btnUncheckAll.ForeColor = 'White'
    $btnUncheckAll.FlatAppearance.BorderSize = 0
    
    # Store reference to list in button Tag for event handler access
    $btnCheckAll.Tag = $list
    $btnUncheckAll.Tag = $list
    
    $btnCheckAll.Add_Click({
        $checkedList = $this.Tag
        for ($i=0; $i -lt $checkedList.Items.Count; $i++) { 
            $checkedList.SetItemChecked($i,$true) 
        }
    })
    
    $btnUncheckAll.Add_Click({
        $checkedList = $this.Tag
        for ($i=0; $i -lt $checkedList.Items.Count; $i++) { 
            $checkedList.SetItemChecked($i,$false) 
        }
    })
    
    $panel.Controls.Add($btnCheckAll)
    $panel.Controls.Add($btnUncheckAll)
    $panel.Controls.Add($list)
    return $panel, $list
}

# ---------- INTERFACE TAB ----------
$interfaceItems = @(
    "AutoRestart Explorer on crash",
    "Show all system icons in tray",
    "Show seconds in system clock",
    "Enable compact view in Explorer",
    "Enable startup sound",
    "Enable dark mode for system and Photo Viewer",
    "Old context menu in Windows 11",
    "Disable Windows widgets",
    "Show hidden files, extensions, system items",
    "Disable context menu delay",
    "Disable notification center",
    "Reduce wallpaper compression",
    "Show drive letter before name",
    "Display shortcut arrows"
)
$interfaceTooltips = @(
    "Auto-restart on crash",
    "Show all tray icons",
    "Show clock seconds",
    "Compact Explorer view",
    "Enable startup sound",
    "Dark theme mode",
    "Classic context menu",
    "Disable widgets panel",
    "Show hidden files",
    "Instant menu response",
    "Disable notifications",
    "100% wallpaper quality",
    "Drive letters first",
    "Show arrow icons"
)
$InterfacePanel,$InterfaceList = New-ChecklistPanel $interfaceItems $interfaceTooltips
$TabInterface.Controls.Add($InterfacePanel)

# Add Apply/Revert buttons for Interface tab
$BtnApplyInterface = New-Object System.Windows.Forms.Button
$BtnApplyInterface.Text = "Apply Interface Tweaks"
$BtnApplyInterface.Size = New-Object System.Drawing.Size(200,35)
$BtnApplyInterface.Location = New-Object System.Drawing.Point(10,450)
$BtnApplyInterface.BackColor = $Accent
$BtnApplyInterface.FlatStyle = 'Flat'
$BtnApplyInterface.ForeColor = 'White'
$BtnApplyInterface.FlatAppearance.BorderSize = 0

$BtnRevertInterface = New-Object System.Windows.Forms.Button
$BtnRevertInterface.Text = "Revert to Default"
$BtnRevertInterface.Size = New-Object System.Drawing.Size(200,35)
$BtnRevertInterface.Location = New-Object System.Drawing.Point(220,450)
$BtnRevertInterface.BackColor = [System.Drawing.Color]::DarkRed
$BtnRevertInterface.FlatStyle = 'Flat'
$BtnRevertInterface.ForeColor = 'White'
$BtnRevertInterface.FlatAppearance.BorderSize = 0

$BtnApplyInterface.Add_Click({
    Write-Log "User applied interface tweaks"
    Apply-InterfaceTweaks
    [System.Windows.Forms.MessageBox]::Show("Interface tweaks applied.","NEFK Tweaker",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Information)
})

$BtnRevertInterface.Add_Click({
    Write-Log "User reverted interface tweaks"
    Revert-InterfaceTweaks
    [System.Windows.Forms.MessageBox]::Show("Interface tweaks reverted.","NEFK Tweaker",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Information)
})

$TabInterface.Controls.Add($BtnApplyInterface)
$TabInterface.Controls.Add($BtnRevertInterface)

# ---------- INTERFACE TWEAKS FUNCTIONS ----------
# Individual interface tweak functions
function Apply-InterfaceTweak-0 { # AutoRestart Explorer
    try {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "AutoRestartShell" -Value 1 -Type DWord -ErrorAction SilentlyContinue
        Write-Log "Enabled AutoRestart Explorer"
    } catch {
        Write-Log "Error enabling AutoRestart Explorer: $_"
    }
}

function Apply-InterfaceTweak-1 { # Show all system icons in tray
    try {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -Value 0 -Type DWord -ErrorAction SilentlyContinue
        Write-Log "All tray icons visible"
    } catch {
        Write-Log "Error showing all tray icons: $_"
    }
}

function Apply-InterfaceTweak-2 { # Show seconds in system clock
    try {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSecondsInSystemClock" -Value 1 -Type DWord -ErrorAction SilentlyContinue
        Write-Log "Show seconds in system clock"
    } catch {
        Write-Log "Error showing seconds in clock: $_"
    }
}

function Apply-InterfaceTweak-3 { # Enable compact view in Explorer
    try {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "UseCompactMode" -Value 1 -Type DWord -ErrorAction SilentlyContinue
        Write-Log "Compact view enabled"
    } catch {
        Write-Log "Error enabling compact view: $_"
    }
}

function Apply-InterfaceTweak-4 { # Enable startup sound
    try {
        Set-ItemProperty -Path "HKCU:\AppEvents\Schemes" -Name "(Default)" -Value ".Current" -ErrorAction SilentlyContinue
        Write-Log "Startup sound enabled"
    } catch {
        Write-Log "Error enabling startup sound: $_"
    }
}

function Apply-InterfaceTweak-5 { # Enable dark mode
    try {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0 -Type DWord -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0 -Type DWord -ErrorAction SilentlyContinue
        Write-Log "Dark mode applied"
    } catch {
        Write-Log "Error enabling dark mode: $_"
    }
}

function Apply-InterfaceTweak-6 { # Old context menu (Win 11)
    try {
        New-Item -Path "HKCU:\Software\Classes\CLSID" -Force | Out-Null
        New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" -Force | Out-Null
        New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Force | Out-Null
        Set-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Name "(default)" -Value "" -Type String -ErrorAction SilentlyContinue
        Write-Log "Old context menu enabled"
    } catch {
        Write-Log "Error enabling old context menu: $_"
    }
}

function Apply-InterfaceTweak-7 { # Disable Widgets
    try {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -Value 0 -Type DWord -ErrorAction SilentlyContinue
        Write-Log "Widgets disabled"
    } catch {
        Write-Log "Error disabling Widgets: $_"
    }
}

function Apply-InterfaceTweak-8 { # Show hidden files, extensions, system items
    try {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1 -Type DWord -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0 -Type DWord -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSuperHidden" -Value 1 -Type DWord -ErrorAction SilentlyContinue
        Write-Log "Hidden files and extensions visible"
    } catch {
        Write-Log "Error showing hidden files: $_"
    }
}

function Apply-InterfaceTweak-9 { # Disable context menu delay
    try {
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Value 0 -Type String -ErrorAction SilentlyContinue
        Write-Log "Menu delay disabled"
    } catch {
        Write-Log "Error disabling menu delay: $_"
    }
}

function Apply-InterfaceTweak-10 { # Disable notification center
    try {
        New-Item -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Force | Out-Null
        Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableNotificationCenter" -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue
        Write-Log "Notification Center disabled"
    } catch {
        Write-Log "Error disabling notification center: $_"
    }
}

function Apply-InterfaceTweak-11 { # Reduce wallpaper compression
    try {
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "JPEGImportQuality" -Value 100 -Type DWord -ErrorAction SilentlyContinue
        Write-Log "Wallpaper compression set to 100% quality"
    } catch {
        Write-Log "Error setting wallpaper quality: $_"
    }
}

function Apply-InterfaceTweak-12 { # Show drive letter before name
    try {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowDriveLettersFirst" -Value 4 -Type DWord -ErrorAction SilentlyContinue
        Write-Log "Drive letters shown before name"
    } catch {
        Write-Log "Error showing drive letters: $_"
    }
}

function Apply-InterfaceTweak-13 { # Display shortcut arrows
    try {
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" -Name "29" -ErrorAction SilentlyContinue
        Write-Log "Shortcut arrows restored"
    } catch {
        Write-Log "Error restoring shortcut arrows: $_"
    }
}

# Legacy function for backward compatibility - applies only checked items
function Apply-InterfaceTweaks {
    Write-Log "Applying selected Interface Tweaks..."
    $appliedCount = 0
    for ($i=0; $i -lt $InterfaceList.Items.Count; $i++) {
        if ($InterfaceList.GetItemChecked($i)) {
            $funcName = "Apply-InterfaceTweak-$i"
            if (Get-Command $funcName -ErrorAction SilentlyContinue) {
                & $funcName
                $appliedCount++
            }
        }
    }
    Write-Log "Applied $appliedCount interface tweak(s) successfully."
}

function Revert-InterfaceTweaks {
    Write-Log "Reverting Interface Tweaks..."

    try {
        Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "AutoRestartShell" -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -Value 1 -Type DWord -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSecondsInSystemClock" -Value 0 -Type DWord -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "UseCompactMode" -Value 0 -Type DWord -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 1 -Type DWord -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 1 -Type DWord -ErrorAction SilentlyContinue
        Remove-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" -Recurse -Force -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -Value 1 -Type DWord -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 2 -Type DWord -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 1 -Type DWord -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSuperHidden" -Value 0 -Type DWord -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Value 400 -Type String -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableNotificationCenter" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "JPEGImportQuality" -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowDriveLettersFirst" -Value 0 -Type DWord -ErrorAction SilentlyContinue
        Write-Log "Interface tweaks reverted to default."
    } catch {
        Write-Log "Error reverting Interface tweaks: $_"
    }
}

# ---------- PERFORMANCE TWEAKS FUNCTIONS ----------
# Individual performance tweak functions
function Apply-PerformanceTweak-0 { # Disable all UI animations
    $visualSettings = @(
        "MinAnimate", "MenuShowDelay", "WindowAnimation", "ListviewAlphaSelect",
        "TooltipAnimation", "ComboBoxAnimation", "CursorShadow", "DragFullWindows",
        "MenuAnimation", "SelectionFade", "TaskbarAnimations"
    )
    foreach ($setting in $visualSettings) {
        try {
            Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name $setting -Value 0 -Type String -ErrorAction SilentlyContinue
        } catch {}
    }
    Write-Log "All UI animations disabled"
}

function Apply-PerformanceTweak-1 { # Disable transparency effects
    try {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 0 -Type DWord -ErrorAction SilentlyContinue
        Write-Log "Transparency disabled"
    } catch {
        Write-Log "Error disabling transparency: $_"
    }
}

function Apply-PerformanceTweak-2 { # Remove startup delay
    try {
        New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" -Force | Out-Null
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" -Name "StartupDelayInMSec" -Value 0 -Type DWord -Force
        # Also set via policies for system-wide effect (if admin)
        try {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize" -Force | Out-Null
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize" -Name "StartupDelayInMSec" -Value 0 -Type DWord -Force -ErrorAction SilentlyContinue
        } catch {
            # Not admin, skip HKLM
        }
        Write-Log "Startup delay removed"
    } catch {
        Write-Log "Error removing startup delay: $_"
    }
}

function Apply-PerformanceTweak-3 { # Disable background apps
    try {
        # Disable for current user
        New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Force | Out-Null
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Name "GlobalUserDisabled" -Value 1 -Type DWord -Force
        # Also disable via policies for system-wide effect (if admin)
        try {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsRunInBackground" -Value 2 -Type DWord -Force -ErrorAction SilentlyContinue
        } catch {
            # Not admin, skip HKLM
        }
        Write-Log "Background apps disabled"
    } catch {
        Write-Log "Error disabling background apps: $_"
    }
}

function Apply-PerformanceTweak-4 { # Disable Prefetch and Superfetch
    try {
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" -Name "EnablePrefetcher" -Value 0 -Type DWord -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" -Name "EnableSuperfetch" -Value 0 -Type DWord -ErrorAction SilentlyContinue
        Write-Log "Prefetch and Superfetch disabled"
    } catch {
        Write-Log "Error disabling Prefetch and Superfetch: $_"
    }
}

function Apply-PerformanceTweak-5 { # Disable Windows tips and suggestions
    try {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338387Enabled" -Value 0 -Type DWord -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353694Enabled" -Value 0 -Type DWord -ErrorAction SilentlyContinue
        Write-Log "Windows tips disabled"
    } catch {
        Write-Log "Error disabling Windows tips: $_"
    }
}

function Apply-PerformanceTweak-6 { # Disable telemetry tasks
    try {
        Get-ScheduledTask | Where-Object {$_.TaskName -match "Telemetry" -or $_.TaskName -match "CEIP"} | Disable-ScheduledTask -ErrorAction SilentlyContinue
        Write-Log "Telemetry scheduled tasks disabled"
    } catch {
        Write-Log "Error disabling telemetry tasks: $_"
    }
}

function Apply-PerformanceTweak-7 { # Disable Windows Error Reporting
    try {
        Set-Service WerSvc -StartupType Disabled -ErrorAction SilentlyContinue
        Stop-Service WerSvc -Force -ErrorAction SilentlyContinue
        Write-Log "Windows Error Reporting service disabled"
    } catch {
        Write-Log "Error disabling Windows Error Reporting: $_"
    }
}

function Apply-PerformanceTweak-8 { # Disable hibernation
    try {
        powercfg /hibernate off | Out-Null
        Write-Log "Hibernation disabled"
    } catch {
        Write-Log "Error disabling hibernation: $_"
    }
}

function Apply-PerformanceTweak-9 { # Set maximum performance power plan
    try {
        powercfg -setactive SCHEME_MIN | Out-Null
        Write-Log "Maximum performance power plan activated"
    } catch {
        Write-Log "Error setting power plan: $_"
    }
}

function Apply-PerformanceTweak-10 { # Set visual effects to performance mode
    try {
        New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Force | Out-Null
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Value 2 -Type DWord -ErrorAction SilentlyContinue
        Write-Log "Windows visual effects set to performance mode"
    } catch {
        Write-Log "Error setting visual effects: $_"
    }
}

function Apply-PerformanceTweak-11 { # Disable all scheduled tasks
    try {
        Write-Log "Disabling all scheduled tasks..."
        $disabledCount = 0
        $allTasks = Get-ScheduledTask -ErrorAction SilentlyContinue
        
        foreach ($task in $allTasks) {
            try {
                # Skip critical system tasks that should not be disabled
                $criticalTasks = @(
                    "Microsoft\Windows\MemoryDiagnostic",
                    "Microsoft\Windows\RAC",
                    "Microsoft\Windows\Registry",
                    "Microsoft\Windows\DiskDiagnostic",
                    "Microsoft\Windows\Defrag"
                )
                
                $isCritical = $false
                foreach ($critical in $criticalTasks) {
                    if ($task.TaskPath -like "*$critical*") {
                        $isCritical = $true
                        break
                    }
                }
                
                if (-not $isCritical -and $task.State -ne "Disabled") {
                    Disable-ScheduledTask -TaskName $task.TaskName -TaskPath $task.TaskPath -ErrorAction SilentlyContinue
                    $disabledCount++
                }
            } catch {
                Write-Log "Error disabling task $($task.TaskName): $_"
            }
        }
        Write-Log "Disabled $disabledCount scheduled task(s)"
    } catch {
        Write-Log "Error disabling scheduled tasks: $_"
    }
}

function Apply-PerformanceTweak-12 { # Disable Windows Search indexing
    try {
        # Disable Windows Search service
        Set-Service WSearch -StartupType Disabled -ErrorAction SilentlyContinue
        Stop-Service WSearch -Force -ErrorAction SilentlyContinue
        # Disable indexing via registry
        New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WSearch" -Force | Out-Null
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WSearch" -Name "Start" -Value 4 -Type DWord -Force
        # Disable indexing for all drives
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\ContentIndex" -Name "Start" -Value 0 -Type DWord -Force -ErrorAction SilentlyContinue
        Write-Log "Windows Search indexing disabled"
    } catch {
        Write-Log "Error disabling Windows Search indexing: $_"
    }
}

function Apply-PerformanceTweak-13 { # Disable font loading delay
    try {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Font Management" -Force | Out-Null
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Font Management" -Name "DelayLoadFont" -Value 0 -Type DWord -Force
        Write-Log "Font loading delay disabled"
    } catch {
        Write-Log "Error disabling font loading delay: $_"
    }
}

function Apply-PerformanceTweak-14 { # Optimize boot timeout
    try {
        # Reduce boot menu timeout
        bcdedit /timeout 0 | Out-Null
        # Disable boot GUI
        bcdedit /set {current} bootmenupolicy standard | Out-Null
        Write-Log "Boot timeout optimized"
    } catch {
        Write-Log "Error optimizing boot timeout: $_"
    }
}

function Apply-PerformanceTweak-15 { # Disable VBS (Virtualization-Based Security)
    try {
        # Disable VBS via bcdedit
        bcdedit /set hypervisorlaunchtype off | Out-Null
        # Also disable via registry
        New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard" -Force | Out-Null
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard" -Name "EnableVirtualizationBasedSecurity" -Value 0 -Type DWord -Force
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard" -Name "RequirePlatformSecurityFeatures" -Value 0 -Type DWord -Force
        Write-Log "VBS (Virtualization-Based Security) disabled - RESTART REQUIRED"
    } catch {
        Write-Log "Error disabling VBS: $_"
    }
}

function Apply-PerformanceTweak-16 { # Optimize Explorer shell loading
    try {
        # Disable shell extensions delay
        New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" -Force | Out-Null
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" -Name "StartupDelayInMSec" -Value 0 -Type DWord -Force
        # Optimize shell loading
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShellState" -Value ([byte[]](0x24,0x00,0x00,0x00,0x37,0xA3,0x10,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x13,0x00,0x00,0x00)) -Type Binary -Force -ErrorAction SilentlyContinue
        # Disable thumbnail cache
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "DisableThumbnailCache" -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue
        Write-Log "Explorer shell loading optimized"
    } catch {
        Write-Log "Error optimizing Explorer shell loading: $_"
    }
}

function Apply-PerformanceTweak-17 { # Clean user temp files
    try {
        $userTemp = $env:TEMP
        $localTemp = "$env:LOCALAPPDATA\Temp"
        $cleaned = 0
        
        if (Test-Path $userTemp) {
            $files = Get-ChildItem -Path $userTemp -Recurse -Force -ErrorAction SilentlyContinue
            $cleaned += $files.Count
            Remove-Item -Path "$userTemp\*" -Recurse -Force -ErrorAction SilentlyContinue
        }
        
        if (Test-Path $localTemp) {
            $files = Get-ChildItem -Path $localTemp -Recurse -Force -ErrorAction SilentlyContinue
            $cleaned += $files.Count
            Remove-Item -Path "$localTemp\*" -Recurse -Force -ErrorAction SilentlyContinue
        }
        
        Write-Log "Cleaned user temp files: $cleaned files removed"
    } catch {
        Write-Log "Error cleaning user temp files: $_"
    }
}

function Apply-PerformanceTweak-18 { # Clean Windows temp files
    try {
        $winTemp = "$env:WINDIR\Temp"
        $cleaned = 0
        
        if (Test-Path $winTemp) {
            $files = Get-ChildItem -Path $winTemp -Recurse -Force -ErrorAction SilentlyContinue
            $cleaned = $files.Count
            Remove-Item -Path "$winTemp\*" -Recurse -Force -ErrorAction SilentlyContinue
        }
        
        Write-Log "Cleaned Windows temp files: $cleaned files removed"
    } catch {
        Write-Log "Error cleaning Windows temp files: $_"
    }
}

function Apply-PerformanceTweak-19 { # Clean Prefetch files
    try {
        $prefetchPath = "$env:WINDIR\Prefetch"
        $cleaned = 0
        
        if (Test-Path $prefetchPath) {
            $files = Get-ChildItem -Path $prefetchPath -Filter "*.pf" -Force -ErrorAction SilentlyContinue
            $cleaned = $files.Count
            Remove-Item -Path "$prefetchPath\*.pf" -Force -ErrorAction SilentlyContinue
        }
        
        Write-Log "Cleaned Prefetch files: $cleaned files removed"
    } catch {
        Write-Log "Error cleaning Prefetch files: $_"
    }
}

function Apply-PerformanceTweak-20 { # Clean browser cache
    try {
        $cleaned = 0
        
        # Standard cache paths
        $cachePaths = @(
            "$env:LOCALAPPDATA\Microsoft\Windows\INetCache",
            "$env:LOCALAPPDATA\Microsoft\Windows\Temporary Internet Files",
            "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache",
            "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Code Cache",
            "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache",
            "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Code Cache"
        )
        
        foreach ($path in $cachePaths) {
            if (Test-Path $path) {
                try {
                    $files = Get-ChildItem -Path $path -Recurse -Force -ErrorAction SilentlyContinue
                    $cleaned += $files.Count
                    Remove-Item -Path "$path\*" -Recurse -Force -ErrorAction SilentlyContinue
                } catch {
                    # Some files may be locked, skip
                }
            }
        }
        
        # Firefox profiles (need to search for profiles)
        $firefoxProfilesPath = "$env:APPDATA\Mozilla\Firefox\Profiles"
        if (Test-Path $firefoxProfilesPath) {
            $profiles = Get-ChildItem -Path $firefoxProfilesPath -Directory -ErrorAction SilentlyContinue
            foreach ($firefoxProfile in $profiles) {
                $cachePaths = @(
                    "$($firefoxProfile.FullName)\cache2",
                    "$($firefoxProfile.FullName)\startupCache"
                )
                foreach ($cachePath in $cachePaths) {
                    if (Test-Path $cachePath) {
                        try {
                            $files = Get-ChildItem -Path $cachePath -Recurse -Force -ErrorAction SilentlyContinue
                            $cleaned += $files.Count
                            Remove-Item -Path "$cachePath\*" -Recurse -Force -ErrorAction SilentlyContinue
                        } catch {}
                    }
                }
            }
        }
        
        Write-Log "Cleaned browser cache: $cleaned files removed"
    } catch {
        Write-Log "Error cleaning browser cache: $_"
    }
}

function Apply-PerformanceTweak-21 { # Clean Recycle Bin
    try {
        $shell = New-Object -ComObject Shell.Application
        $recycleBin = $shell.NameSpace(0xA)
        $items = $recycleBin.Items()
        $count = $items.Count
        
        foreach ($item in $items) {
            Remove-Item -Path $item.Path -Recurse -Force -ErrorAction SilentlyContinue
        }
        
        # Also use Clear-RecycleBin cmdlet if available
        try {
            Clear-RecycleBin -Force -ErrorAction SilentlyContinue
        } catch {}
        
        Write-Log "Cleaned Recycle Bin: $count items removed"
    } catch {
        Write-Log "Error cleaning Recycle Bin: $_"
    }
}

function Apply-PerformanceTweak-22 { # Clean Windows Update cache
    try {
        $updatePaths = @(
            "$env:WINDIR\SoftwareDistribution\Download",
            "$env:WINDIR\SoftwareDistribution\DataStore"
        )
        $cleaned = 0
        
        # Stop Windows Update service temporarily
        try {
            Stop-Service wuauserv -Force -ErrorAction SilentlyContinue
            Start-Sleep -Seconds 2
        } catch {}
        
        foreach ($path in $updatePaths) {
            if (Test-Path $path) {
                try {
                    $files = Get-ChildItem -Path $path -Recurse -Force -ErrorAction SilentlyContinue
                    $cleaned += $files.Count
                    Remove-Item -Path "$path\*" -Recurse -Force -ErrorAction SilentlyContinue
                } catch {
                    # Some files may be locked
                }
            }
        }
        
        # Restart Windows Update service
        try {
            Start-Service wuauserv -ErrorAction SilentlyContinue
        } catch {}
        
        Write-Log "Cleaned Windows Update cache: $cleaned files removed"
    } catch {
        Write-Log "Error cleaning Windows Update cache: $_"
    }
}

function Apply-PerformanceTweak-23 { # Clean DNS cache
    try {
        Write-Log "Flushing DNS cache..."
        ipconfig /flushdns | Out-Null
        Write-Log "DNS cache flushed"
    } catch {
        Write-Log "Error flushing DNS cache: $_"
    }
}

function Apply-PerformanceTweak-24 { # Clean thumbnail cache
    try {
        $thumbnailDir = "$env:LOCALAPPDATA\Microsoft\Windows\Explorer"
        $cleaned = 0
        
        if (Test-Path $thumbnailDir) {
            $patterns = @("thumbcache_*.db", "thumbcache_*.db1", "thumbcache_*.db2", "thumbcache_*.db3", "thumbcache_*.db4", "thumbcache_*.db5", "iconcache_*.db")
            
            foreach ($pattern in $patterns) {
                $files = Get-ChildItem -Path $thumbnailDir -Filter $pattern -Force -ErrorAction SilentlyContinue
                foreach ($file in $files) {
                    try {
                        Remove-Item -Path $file.FullName -Force -ErrorAction SilentlyContinue
                        $cleaned++
                    } catch {}
                }
            }
        }
        
        # Also clear thumbnail cache via registry
        try {
            Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Thumbnail Cache" -Name "StateFlags0001" -ErrorAction SilentlyContinue
        } catch {}
        
        Write-Log "Cleaned thumbnail cache: $cleaned files removed"
    } catch {
        Write-Log "Error cleaning thumbnail cache: $_"
    }
}

function Apply-PerformanceTweak-25 { # Clean Windows logs
    try {
        $logPaths = @(
            "$env:WINDIR\Logs",
            "$env:WINDIR\Panther",
            "$env:WINDIR\Debug",
            "$env:WINDIR\Minidump"
        )
        $cleaned = 0
        
        foreach ($path in $logPaths) {
            if (Test-Path $path) {
                try {
                    $files = Get-ChildItem -Path $path -Recurse -Force -ErrorAction SilentlyContinue | Where-Object {!$_.PSIsContainer}
                    $cleaned += $files.Count
                    Remove-Item -Path "$path\*" -Recurse -Force -ErrorAction SilentlyContinue
                } catch {
                    # Some files may be locked
                }
            }
        }
        
        Write-Log "Cleaned Windows logs: $cleaned files removed"
    } catch {
        Write-Log "Error cleaning Windows logs: $_"
    }
}

function Apply-PerformanceTweak-26 { # Clean Event logs
    try {
        $cleaned = 0
        $eventLogs = Get-EventLog -List | Where-Object {$_.Log -ne "Security"} # Don't clear Security log
        
        foreach ($log in $eventLogs) {
            try {
                $count = $log.Entries.Count
                Clear-EventLog -LogName $log.Log -ErrorAction SilentlyContinue
                $cleaned += $count
            } catch {
                # Some logs may be protected
            }
        }
        
        Write-Log "Cleaned Event logs: $cleaned entries removed"
    } catch {
        Write-Log "Error cleaning Event logs: $_"
    }
}

function Apply-PerformanceTweak-27 { # Clean Microsoft Store cache
    try {
        $storeBasePath = "$env:LOCALAPPDATA\Packages"
        $cleaned = 0
        
        if (Test-Path $storeBasePath) {
            $storeDirs = Get-ChildItem -Path $storeBasePath -Filter "Microsoft.WindowsStore_*" -Directory -Force -ErrorAction SilentlyContinue
            foreach ($storeDir in $storeDirs) {
                $cachePaths = @(
                    "$($storeDir.FullName)\LocalCache",
                    "$($storeDir.FullName)\TempState"
                )
                foreach ($cachePath in $cachePaths) {
                    if (Test-Path $cachePath) {
                        try {
                            $files = Get-ChildItem -Path $cachePath -Recurse -Force -ErrorAction SilentlyContinue
                            $cleaned += $files.Count
                            Remove-Item -Path "$cachePath\*" -Recurse -Force -ErrorAction SilentlyContinue
                        } catch {}
                    }
                }
            }
        }
        
        # Also clear INetCache
        $inetCache = "$env:LOCALAPPDATA\Microsoft\Windows\INetCache"
        if (Test-Path $inetCache) {
            try {
                $files = Get-ChildItem -Path $inetCache -Recurse -Force -ErrorAction SilentlyContinue
                $cleaned += $files.Count
                Remove-Item -Path "$inetCache\*" -Recurse -Force -ErrorAction SilentlyContinue
            } catch {}
        }
        
        # Also run wsreset
        try {
            Start-Process -FilePath "wsreset.exe" -ArgumentList "/s" -Wait -NoNewWindow -ErrorAction SilentlyContinue
        } catch {}
        
        Write-Log "Cleaned Microsoft Store cache: $cleaned files removed"
    } catch {
        Write-Log "Error cleaning Microsoft Store cache: $_"
    }
}

function Apply-PerformanceTweak-28 { # Clean Delivery Optimization cache
    try {
        $doPath = "$env:LOCALAPPDATA\Microsoft\Windows\DeliveryOptimization\Cache"
        $cleaned = 0
        
        if (Test-Path $doPath) {
            try {
                $files = Get-ChildItem -Path $doPath -Recurse -Force -ErrorAction SilentlyContinue
                $cleaned = $files.Count
                Remove-Item -Path "$doPath\*" -Recurse -Force -ErrorAction SilentlyContinue
            } catch {
                # Some files may be locked
            }
        }
        
        # Also clear via service
        try {
            Stop-Service dosvc -Force -ErrorAction SilentlyContinue
            Start-Sleep -Seconds 2
            if (Test-Path $doPath) {
                Remove-Item -Path "$doPath\*" -Recurse -Force -ErrorAction SilentlyContinue
            }
            Start-Service dosvc -ErrorAction SilentlyContinue
        } catch {}
        
        Write-Log "Cleaned Delivery Optimization cache: $cleaned files removed"
    } catch {
        Write-Log "Error cleaning Delivery Optimization cache: $_"
    }
}

function Apply-PerformanceTweak-29 { # Clean Windows error reports
    try {
        $errorReportPaths = @(
            "$env:LOCALAPPDATA\Microsoft\Windows\WER",
            "$env:PROGRAMDATA\Microsoft\Windows\WER"
        )
        $cleaned = 0
        
        foreach ($path in $errorReportPaths) {
            if (Test-Path $path) {
                try {
                    $files = Get-ChildItem -Path $path -Recurse -Force -ErrorAction SilentlyContinue
                    $cleaned += $files.Count
                    Remove-Item -Path "$path\*" -Recurse -Force -ErrorAction SilentlyContinue
                } catch {
                    # Some files may be locked
                }
            }
        }
        
        Write-Log "Cleaned Windows error reports: $cleaned files removed"
    } catch {
        Write-Log "Error cleaning Windows error reports: $_"
    }
}

function Apply-PerformanceTweak-30 { # Clean Recent files
    try {
        $recentPaths = @(
            "$env:APPDATA\Microsoft\Windows\Recent",
            "$env:APPDATA\Microsoft\Windows\Recent\AutomaticDestinations",
            "$env:APPDATA\Microsoft\Windows\Recent\CustomDestinations"
        )
        $cleaned = 0
        
        foreach ($path in $recentPaths) {
            if (Test-Path $path) {
                try {
                    $files = Get-ChildItem -Path $path -Force -ErrorAction SilentlyContinue
                    $cleaned += $files.Count
                    Remove-Item -Path "$path\*" -Recurse -Force -ErrorAction SilentlyContinue
                } catch {}
            }
        }
        
        Write-Log "Cleaned Recent files: $cleaned files removed"
    } catch {
        Write-Log "Error cleaning Recent files: $_"
    }
}

function Apply-PerformanceTweak-31 { # Clean Windows Defender cache
    try {
        $defenderPaths = @(
            "$env:PROGRAMDATA\Microsoft\Windows Defender\Scans\FilesStash",
            "$env:PROGRAMDATA\Microsoft\Windows Defender\Support"
        )
        $cleaned = 0
        
        foreach ($path in $defenderPaths) {
            if (Test-Path $path) {
                try {
                    $files = Get-ChildItem -Path $path -Recurse -Force -ErrorAction SilentlyContinue
                    $cleaned += $files.Count
                    Remove-Item -Path "$path\*" -Recurse -Force -ErrorAction SilentlyContinue
                } catch {
                    # Some files may be locked
                }
            }
        }
        
        Write-Log "Cleaned Windows Defender cache: $cleaned files removed"
    } catch {
        Write-Log "Error cleaning Windows Defender cache: $_"
    }
}

function Apply-PerformanceTweak-32 { # Clean all temp files
    try {
        Write-Log "Cleaning all temp files..."
        Apply-PerformanceTweak-17 # User temp
        Apply-PerformanceTweak-18 # Windows temp
        Apply-PerformanceTweak-19 # Prefetch
        Apply-PerformanceTweak-20 # Browser cache
        Apply-PerformanceTweak-21 # Recycle Bin
        Apply-PerformanceTweak-22 # Windows Update cache
        Apply-PerformanceTweak-23 # DNS cache
        Apply-PerformanceTweak-24 # Thumbnail cache
        Apply-PerformanceTweak-25 # Windows logs
        Apply-PerformanceTweak-26 # Event logs
        Apply-PerformanceTweak-27 # Microsoft Store cache
        Apply-PerformanceTweak-28 # Delivery Optimization cache
        Apply-PerformanceTweak-29 # Windows error reports
        Apply-PerformanceTweak-30 # Recent files
        Apply-PerformanceTweak-31 # Windows Defender cache
        
        # Additional cleanup
        $additionalPaths = @(
            "$env:LOCALAPPDATA\Microsoft\Windows\WebCache",
            "$env:LOCALAPPDATA\Microsoft\Windows\History",
            "$env:LOCALAPPDATA\Microsoft\Office\16.0\OfficeFileCache",
            "$env:LOCALAPPDATA\Microsoft\Office\16.0\OfficeFileCache",
            "$env:LOCALAPPDATA\Microsoft\Windows\Explorer\Recent",
            "$env:APPDATA\Microsoft\Windows\Libraries"
        )
        
        foreach ($path in $additionalPaths) {
            if (Test-Path $path) {
                try {
                    Remove-Item -Path "$path\*" -Recurse -Force -ErrorAction SilentlyContinue
                } catch {}
            }
        }
        
        Write-Log "All temp files cleaned"
    } catch {
        Write-Log "Error cleaning all temp files: $_"
    }
}

# Legacy function for backward compatibility - applies only checked items
function Apply-PerformanceTweaks {
    Write-Log "Applying selected Performance Tweaks..."
    $appliedCount = 0
    for ($i=0; $i -lt $PerformanceList.Items.Count; $i++) {
        if ($PerformanceList.GetItemChecked($i)) {
            $funcName = "Apply-PerformanceTweak-$i"
            if (Get-Command $funcName -ErrorAction SilentlyContinue) {
                & $funcName
                $appliedCount++
            }
        }
    }
    Write-Log "Applied $appliedCount performance tweak(s) successfully."
}

function Revert-PerformanceTweaks {
    Write-Log "Reverting Performance Tweaks..."

    # Restore visual animations
    $visualSettings = @(
        "MinAnimate", "WindowAnimation", "TooltipAnimation", "MenuAnimation", "SelectionFade"
    )
    foreach ($setting in $visualSettings) {
        try {
            Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name $setting -Value 1 -Type String -ErrorAction SilentlyContinue
        } catch {}
    }
    Write-Log "UI animations restored"

    # Restore transparency
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 1 -Type DWord
    Write-Log "Transparency restored"

    # Enable prefetch/superfetch
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" -Name "EnablePrefetcher" -Value 3 -Type DWord
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" -Name "EnableSuperfetch" -Value 3 -Type DWord
    Write-Log "Prefetch and Superfetch re-enabled"

    # Enable hibernation
    powercfg /hibernate on | Out-Null
    Write-Log "Hibernation re-enabled"

    # Restore Balanced power plan
    powercfg -setactive SCHEME_BALANCED | Out-Null
    Write-Log "Balanced power plan restored"

    # Restore startup delay
    try {
        Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" -Name "StartupDelayInMSec" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize" -Name "StartupDelayInMSec" -ErrorAction SilentlyContinue
        Write-Log "Startup delay restored"
    } catch {
        Write-Log "Error restoring startup delay: $_"
    }

    # Re-enable background apps
    try {
        Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Name "GlobalUserDisabled" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsRunInBackground" -ErrorAction SilentlyContinue
        Write-Log "Background apps re-enabled"
    } catch {
        Write-Log "Error re-enabling background apps: $_"
    }

    # Re-enable scheduled tasks (enable all disabled tasks)
    try {
        Write-Log "Re-enabling scheduled tasks..."
        $enabledCount = 0
        $allTasks = Get-ScheduledTask -ErrorAction SilentlyContinue
        
        foreach ($task in $allTasks) {
            try {
                if ($task.State -eq "Disabled") {
                    Enable-ScheduledTask -TaskName $task.TaskName -TaskPath $task.TaskPath -ErrorAction SilentlyContinue
                    $enabledCount++
                }
            } catch {
                Write-Log "Error enabling task $($task.TaskName): $_"
            }
        }
        Write-Log "Re-enabled $enabledCount scheduled task(s)"
    } catch {
        Write-Log "Error re-enabling scheduled tasks: $_"
    }

    # Re-enable Windows Search indexing
    try {
        Set-Service WSearch -StartupType Automatic -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WSearch" -Name "Start" -Value 2 -Type DWord -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\ContentIndex" -Name "Start" -Value 1 -Type DWord -ErrorAction SilentlyContinue
        Write-Log "Windows Search indexing re-enabled"
    } catch {
        Write-Log "Error re-enabling Windows Search: $_"
    }

    # Restore font loading delay
    try {
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Font Management" -Name "DelayLoadFont" -ErrorAction SilentlyContinue
        Write-Log "Font loading delay restored"
    } catch {
        Write-Log "Error restoring font loading delay: $_"
    }

    # Restore boot timeout
    try {
        bcdedit /timeout 30 | Out-Null
        Write-Log "Boot timeout restored"
    } catch {
        Write-Log "Error restoring boot timeout: $_"
    }

    # Re-enable VBS
    try {
        bcdedit /set hypervisorlaunchtype auto | Out-Null
        Remove-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard" -Name "EnableVirtualizationBasedSecurity" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard" -Name "RequirePlatformSecurityFeatures" -ErrorAction SilentlyContinue
        Write-Log "VBS re-enabled - RESTART REQUIRED"
    } catch {
        Write-Log "Error re-enabling VBS: $_"
    }

    # Restore Explorer shell loading
    try {
        Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "DisableThumbnailCache" -ErrorAction SilentlyContinue
        Write-Log "Explorer shell loading restored"
    } catch {
        Write-Log "Error restoring Explorer shell loading: $_"
    }

    Write-Log "Performance tweaks reverted to default."
}

# ---------- PERFORMANCE TAB UI ----------
$performanceItems = @(
    "Disable all UI animations",
    "Disable transparency effects",
    "Remove startup delay",
    "Disable background apps",
    "Disable Prefetch and Superfetch",
    "Disable Windows tips and suggestions",
    "Disable telemetry tasks",
    "Disable Windows Error Reporting",
    "Disable hibernation",
    "Set maximum performance power plan",
    "Set visual effects to performance mode",
    "Disable all scheduled tasks",
    "Disable Windows Search indexing",
    "Disable font loading delay",
    "Optimize boot timeout",
    "Disable VBS (Virtualization-Based Security)",
    "Optimize Explorer shell loading",
    "Clean user temp files",
    "Clean Windows temp files",
    "Clean Prefetch files",
    "Clean browser cache",
    "Clean Recycle Bin",
    "Clean Windows Update cache",
    "Clean DNS cache",
    "Clean thumbnail cache",
    "Clean Windows logs",
    "Clean Event logs",
    "Clean Microsoft Store cache",
    "Clean Delivery Optimization cache",
    "Clean Windows error reports",
    "Clean Recent files",
    "Clean Windows Defender cache",
    "Clean all temp files"
)
$performanceTooltips = @(
    "No animations",
    "Disable transparency",
    "Faster boot",
    "Stop background apps",
    "Disable prefetch",
    "No tips",
    "Disable telemetry",
    "No error reports",
    "No hibernation",
    "Max power plan",
    "Performance mode",
    "Disable tasks",
    "No indexing",
    "Fast fonts",
    "Quick boot",
    "Disable VBS",
    "Fast Explorer",
    "Clear user temp",
    "Clear Windows temp",
    "Clear prefetch",
    "Clear browser cache",
    "Empty Recycle Bin",
    "Clear update cache",
    "Flush DNS cache",
    "Clear thumbnails",
    "Clear Windows logs",
    "Clear Event logs",
    "Clear Store cache",
    "Clear delivery cache",
    "Clear error reports",
    "Clear recent files",
    "Clear Defender cache",
    "Clean everything"
)
$PerformancePanel,$PerformanceList = New-ChecklistPanel $performanceItems $performanceTooltips
$TabPerformance.Controls.Add($PerformancePanel)

# Add Apply/Revert buttons for Performance tab
$BtnApplyPerf = New-Object System.Windows.Forms.Button
$BtnApplyPerf.Text = "Apply Performance Tweaks"
$BtnApplyPerf.Size = New-Object System.Drawing.Size(200,35)
$BtnApplyPerf.Location = New-Object System.Drawing.Point(10,450)
$BtnApplyPerf.BackColor = $Accent
$BtnApplyPerf.FlatStyle = 'Flat'
$BtnApplyPerf.ForeColor = 'White'
$BtnApplyPerf.FlatAppearance.BorderSize = 0

$BtnRevertPerf = New-Object System.Windows.Forms.Button
$BtnRevertPerf.Text = "Revert to Default"
$BtnRevertPerf.Size = New-Object System.Drawing.Size(200,35)
$BtnRevertPerf.Location = New-Object System.Drawing.Point(220,450)
$BtnRevertPerf.BackColor = [System.Drawing.Color]::DarkRed
$BtnRevertPerf.FlatStyle = 'Flat'
$BtnRevertPerf.ForeColor = 'White'
$BtnRevertPerf.FlatAppearance.BorderSize = 0

$BtnApplyPerf.Add_Click({
    Write-Log "User applied performance tweaks"
    Apply-PerformanceTweaks
    [System.Windows.Forms.MessageBox]::Show("Extreme performance tweaks applied.","NEFK Tweaker",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Information)
})

$BtnRevertPerf.Add_Click({
    Write-Log "User reverted performance tweaks"
    Revert-PerformanceTweaks
    [System.Windows.Forms.MessageBox]::Show("Performance tweaks reverted.","NEFK Tweaker",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Information)
})

$TabPerformance.Controls.Add($BtnApplyPerf)
$TabPerformance.Controls.Add($BtnRevertPerf)

# ---------- SERVICES TAB (placeholder) ----------
$servicesItems = @(
    "Windows Update",
    "Windows Search",
    "Windows Error Reporting",
    "Windows Telemetry"
)
$servicesTooltips = @(
    "Disable updates",
    "Disable search",
    "No error reports",
    "Disable telemetry"
)
$ServicesPanel,$ServicesList = New-ChecklistPanel $servicesItems $servicesTooltips
$TabServices.Controls.Add($ServicesPanel)

# Add Apply/Revert buttons for Services tab
$BtnApplyServices = New-Object System.Windows.Forms.Button
$BtnApplyServices.Text = "Apply Services Tweaks"
$BtnApplyServices.Size = New-Object System.Drawing.Size(200,35)
$BtnApplyServices.Location = New-Object System.Drawing.Point(10,450)
$BtnApplyServices.BackColor = $Accent
$BtnApplyServices.FlatStyle = 'Flat'
$BtnApplyServices.ForeColor = 'White'
$BtnApplyServices.FlatAppearance.BorderSize = 0

$BtnRevertServices = New-Object System.Windows.Forms.Button
$BtnRevertServices.Text = "Revert to Default"
$BtnRevertServices.Size = New-Object System.Drawing.Size(200,35)
$BtnRevertServices.Location = New-Object System.Drawing.Point(220,450)
$BtnRevertServices.BackColor = [System.Drawing.Color]::DarkRed
$BtnRevertServices.FlatStyle = 'Flat'
$BtnRevertServices.ForeColor = 'White'
$BtnRevertServices.FlatAppearance.BorderSize = 0

$TabServices.Controls.Add($BtnApplyServices)
$TabServices.Controls.Add($BtnRevertServices)

# ---------- SERVICES TWEAKS FUNCTIONS ----------
function Apply-ServicesTweak-0 { # Disable Windows Update
    try {
        Set-Service wuauserv -StartupType Disabled -ErrorAction SilentlyContinue
        Stop-Service wuauserv -Force -ErrorAction SilentlyContinue
        Write-Log "Windows Update service disabled"
    } catch {
        Write-Log "Error disabling Windows Update service: $_"
    }
}

function Apply-ServicesTweak-1 { # Disable Windows Search
    try {
        Set-Service WSearch -StartupType Disabled -ErrorAction SilentlyContinue
        Stop-Service WSearch -Force -ErrorAction SilentlyContinue
        Write-Log "Windows Search service disabled"
    } catch {
        Write-Log "Error disabling Windows Search service: $_"
    }
}

function Apply-ServicesTweak-2 { # Disable Windows Error Reporting
    try {
        Set-Service WerSvc -StartupType Disabled -ErrorAction SilentlyContinue
        Stop-Service WerSvc -Force -ErrorAction SilentlyContinue
        Write-Log "Windows Error Reporting service disabled"
    } catch {
        Write-Log "Error disabling Windows Error Reporting service: $_"
    }
}

function Apply-ServicesTweak-3 { # Disable Windows Telemetry
    try {
        Set-Service DiagTrack -StartupType Disabled -ErrorAction SilentlyContinue
        Stop-Service DiagTrack -Force -ErrorAction SilentlyContinue
        Write-Log "Windows Telemetry service disabled"
    } catch {
        Write-Log "Error disabling Windows Telemetry service: $_"
    }
}

function Apply-ServicesTweaks {
    Write-Log "Applying selected Services Tweaks..."
    $appliedCount = 0
    for ($i=0; $i -lt $ServicesList.Items.Count; $i++) {
        if ($ServicesList.GetItemChecked($i)) {
            $funcName = "Apply-ServicesTweak-$i"
            if (Get-Command $funcName -ErrorAction SilentlyContinue) {
                & $funcName
                $appliedCount++
            }
        }
    }
    Write-Log "Applied $appliedCount service tweak(s) successfully."
}

function Revert-ServicesTweaks {
    Write-Log "Reverting Services Tweaks..."
    Set-Service wuauserv -StartupType Manual -ErrorAction SilentlyContinue
    Set-Service WSearch -StartupType Automatic -ErrorAction SilentlyContinue
    Set-Service WerSvc -StartupType Manual -ErrorAction SilentlyContinue
    Set-Service DiagTrack -StartupType Manual -ErrorAction SilentlyContinue
    Write-Log "Services tweaks reverted to default."
}

$BtnApplyServices.Add_Click({
    Write-Log "User applied services tweaks"
    Apply-ServicesTweaks
    [System.Windows.Forms.MessageBox]::Show("Services tweaks applied.","NEFK Tweaker",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Information)
})

$BtnRevertServices.Add_Click({
    Write-Log "User reverted services tweaks"
    Revert-ServicesTweaks
    [System.Windows.Forms.MessageBox]::Show("Services tweaks reverted.","NEFK Tweaker",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Information)
})

# ---------- PRIVACY TAB (placeholder) ----------
$privacyItems = @(
    "Disable telemetry",
    "Disable advertising ID",
    "Disable location services",
    "Disable Cortana",
    "Disable Windows tips"
)
$privacyTooltips = @(
    "No telemetry",
    "No ads ID",
    "No location",
    "Disable Cortana",
    "No tips"
)
$PrivacyPanel,$PrivacyList = New-ChecklistPanel $privacyItems $privacyTooltips
$TabPrivacy.Controls.Add($PrivacyPanel)

# Add Apply/Revert buttons for Privacy tab
$BtnApplyPrivacy = New-Object System.Windows.Forms.Button
$BtnApplyPrivacy.Text = "Apply Privacy Tweaks"
$BtnApplyPrivacy.Size = New-Object System.Drawing.Size(200,35)
$BtnApplyPrivacy.Location = New-Object System.Drawing.Point(10,450)
$BtnApplyPrivacy.BackColor = $Accent
$BtnApplyPrivacy.FlatStyle = 'Flat'
$BtnApplyPrivacy.ForeColor = 'White'
$BtnApplyPrivacy.FlatAppearance.BorderSize = 0

$BtnRevertPrivacy = New-Object System.Windows.Forms.Button
$BtnRevertPrivacy.Text = "Revert to Default"
$BtnRevertPrivacy.Size = New-Object System.Drawing.Size(200,35)
$BtnRevertPrivacy.Location = New-Object System.Drawing.Point(220,450)
$BtnRevertPrivacy.BackColor = [System.Drawing.Color]::DarkRed
$BtnRevertPrivacy.FlatStyle = 'Flat'
$BtnRevertPrivacy.ForeColor = 'White'
$BtnRevertPrivacy.FlatAppearance.BorderSize = 0

$TabPrivacy.Controls.Add($BtnApplyPrivacy)
$TabPrivacy.Controls.Add($BtnRevertPrivacy)

# ---------- PRIVACY TWEAKS FUNCTIONS ----------
function Apply-PrivacyTweak-0 { # Disable telemetry
    try {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Force | Out-Null
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -Type DWord -Force
        Set-Service DiagTrack -StartupType Disabled -ErrorAction SilentlyContinue
        Stop-Service DiagTrack -Force -ErrorAction SilentlyContinue
        Write-Log "Telemetry disabled"
    } catch {
        Write-Log "Error disabling telemetry: $_"
    }
}

function Apply-PrivacyTweak-1 { # Disable advertising ID
    try {
        New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Force | Out-Null
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "Enabled" -Value 0 -Type DWord -Force
        Write-Log "Advertising ID disabled"
    } catch {
        Write-Log "Error disabling advertising ID: $_"
    }
}

function Apply-PrivacyTweak-2 { # Disable location services
    try {
        # Disable via registry
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides" -Force | Out-Null
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Force | Out-Null
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState" -Value 0 -Type DWord -Force
        # Also disable via policies
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Force | Out-Null
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableLocation" -Value 1 -Type DWord -Force
        # Disable service
        Set-Service lfsvc -StartupType Disabled -ErrorAction SilentlyContinue
        Stop-Service lfsvc -Force -ErrorAction SilentlyContinue
        Write-Log "Location services disabled"
    } catch {
        Write-Log "Error disabling location services: $_"
    }
}

function Apply-PrivacyTweak-3 { # Disable Cortana
    try {
        # Disable Cortana via user registry
        New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Force | Out-Null
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaEnabled" -Value 0 -Type DWord -Force
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "CanCortanaBeEnabled" -Value 0 -Type DWord -Force
        # Disable via policies
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Value 0 -Type DWord -Force
        # Also disable via system registry
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\Search\AllowCortana" -Force | Out-Null
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\Search\AllowCortana" -Name "Value" -Value 0 -Type DWord -Force
        Write-Log "Cortana disabled"
    } catch {
        Write-Log "Error disabling Cortana: $_"
    }
}

function Apply-PrivacyTweak-4 { # Disable Windows tips
    try {
        New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Force | Out-Null
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338387Enabled" -Value 0 -Type DWord -Force
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353694Enabled" -Value 0 -Type DWord -Force
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353696Enabled" -Value 0 -Type DWord -Force
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Value 0 -Type DWord -Force
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SoftLandingEnabled" -Value 0 -Type DWord -Force
        Write-Log "Windows tips disabled"
    } catch {
        Write-Log "Error disabling Windows tips: $_"
    }
}

function Apply-PrivacyTweaks {
    Write-Log "Applying selected Privacy Tweaks..."
    $appliedCount = 0
    for ($i=0; $i -lt $PrivacyList.Items.Count; $i++) {
        if ($PrivacyList.GetItemChecked($i)) {
            $funcName = "Apply-PrivacyTweak-$i"
            if (Get-Command $funcName -ErrorAction SilentlyContinue) {
                & $funcName
                $appliedCount++
            }
        }
    }
    Write-Log "Applied $appliedCount privacy tweak(s) successfully."
}

function Revert-PrivacyTweaks {
    Write-Log "Reverting Privacy Tweaks..."
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -ErrorAction SilentlyContinue
    Set-Service DiagTrack -StartupType Manual -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "Enabled" -ErrorAction SilentlyContinue
    # Revert location services
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableLocation" -ErrorAction SilentlyContinue
    Set-Service lfsvc -StartupType Manual -ErrorAction SilentlyContinue
    # Revert Cortana
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaEnabled" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "CanCortanaBeEnabled" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\Search\AllowCortana" -Name "Value" -ErrorAction SilentlyContinue
    # Revert Windows tips
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338387Enabled" -Value 1 -Type DWord -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353694Enabled" -Value 1 -Type DWord -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353696Enabled" -Value 1 -Type DWord -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SoftLandingEnabled" -ErrorAction SilentlyContinue
    Write-Log "Privacy tweaks reverted to default."
}

$BtnApplyPrivacy.Add_Click({
    Write-Log "User applied privacy tweaks"
    Apply-PrivacyTweaks
    [System.Windows.Forms.MessageBox]::Show("Privacy tweaks applied.","NEFK Tweaker",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Information)
})

$BtnRevertPrivacy.Add_Click({
    Write-Log "User reverted privacy tweaks"
    Revert-PrivacyTweaks
    [System.Windows.Forms.MessageBox]::Show("Privacy tweaks reverted.","NEFK Tweaker",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Information)
})

# ---------- SYSTEM TAB (placeholder) ----------
$systemItems = @(
    "Disable Windows Update",
    "Disable UAC",
    "Disable Windows Firewall"
)
$systemTooltips = @(
    "No updates",
    "No UAC prompts",
    "Disable firewall"
)
$SystemPanel,$SystemList = New-ChecklistPanel $systemItems $systemTooltips
$TabSystem.Controls.Add($SystemPanel)

# Add Apply/Revert buttons for System tab
$BtnApplySystem = New-Object System.Windows.Forms.Button
$BtnApplySystem.Text = "Apply System Tweaks"
$BtnApplySystem.Size = New-Object System.Drawing.Size(200,35)
$BtnApplySystem.Location = New-Object System.Drawing.Point(10,450)
$BtnApplySystem.BackColor = $Accent
$BtnApplySystem.FlatStyle = 'Flat'
$BtnApplySystem.ForeColor = 'White'
$BtnApplySystem.FlatAppearance.BorderSize = 0

$BtnRevertSystem = New-Object System.Windows.Forms.Button
$BtnRevertSystem.Text = "Revert to Default"
$BtnRevertSystem.Size = New-Object System.Drawing.Size(200,35)
$BtnRevertSystem.Location = New-Object System.Drawing.Point(220,450)
$BtnRevertSystem.BackColor = [System.Drawing.Color]::DarkRed
$BtnRevertSystem.FlatStyle = 'Flat'
$BtnRevertSystem.ForeColor = 'White'
$BtnRevertSystem.FlatAppearance.BorderSize = 0

$TabSystem.Controls.Add($BtnApplySystem)
$TabSystem.Controls.Add($BtnRevertSystem)

# ---------- SYSTEM TWEAKS FUNCTIONS ----------
function Apply-SystemTweak-0 { # Disable Windows Update
    try {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force | Out-Null
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoUpdate" -Value 1 -Type DWord -Force
        Set-Service wuauserv -StartupType Disabled -ErrorAction SilentlyContinue
        Stop-Service wuauserv -Force -ErrorAction SilentlyContinue
        Write-Log "Windows Update disabled"
    } catch {
        Write-Log "Error disabling Windows Update: $_"
    }
}

function Apply-SystemTweak-1 { # Disable UAC
    try {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Force | Out-Null
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Value 0 -Type DWord -Force
        # Also set ConsentPromptBehaviorAdmin to 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 0 -Type DWord -Force
        Write-Log "UAC disabled (restart required)"
    } catch {
        Write-Log "Error disabling UAC: $_"
    }
}

function Apply-SystemTweak-2 { # Disable Windows Firewall
    try {
        # Disable via PowerShell cmdlet
        Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False -ErrorAction SilentlyContinue
        # Disable via registry (more reliable)
        New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile" -Force | Out-Null
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile" -Name "EnableFirewall" -Value 0 -Type DWord -Force
        New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile" -Force | Out-Null
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile" -Name "EnableFirewall" -Value 0 -Type DWord -Force
        New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile" -Force | Out-Null
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile" -Name "EnableFirewall" -Value 0 -Type DWord -Force
        # Disable service
        Set-Service mpssvc -StartupType Disabled -ErrorAction SilentlyContinue
        Stop-Service mpssvc -Force -ErrorAction SilentlyContinue
        Write-Log "Windows Firewall disabled"
    } catch {
        Write-Log "Error disabling Windows Firewall: $_"
    }
}

function Apply-SystemTweaks {
    Write-Log "Applying selected System Tweaks..."
    $appliedCount = 0
    for ($i=0; $i -lt $SystemList.Items.Count; $i++) {
        if ($SystemList.GetItemChecked($i)) {
            $funcName = "Apply-SystemTweak-$i"
            if (Get-Command $funcName -ErrorAction SilentlyContinue) {
                & $funcName
                $appliedCount++
            }
        }
    }
    Write-Log "Applied $appliedCount system tweak(s) successfully."
}

function Revert-SystemTweaks {
    Write-Log "Reverting System Tweaks..."
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoUpdate" -ErrorAction SilentlyContinue
    Set-Service wuauserv -StartupType Manual -ErrorAction SilentlyContinue
    # Re-enable UAC
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Value 1 -Type DWord -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 5 -Type DWord -ErrorAction SilentlyContinue
    # Re-enable firewall via PowerShell and registry
    Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile" -Name "EnableFirewall" -Value 1 -Type DWord -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile" -Name "EnableFirewall" -Value 1 -Type DWord -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile" -Name "EnableFirewall" -Value 1 -Type DWord -ErrorAction SilentlyContinue
    Set-Service mpssvc -StartupType Automatic -ErrorAction SilentlyContinue
    Write-Log "System tweaks reverted to default."
}

$BtnApplySystem.Add_Click({
    $result = [System.Windows.Forms.MessageBox]::Show(
        "WARNING: Disabling UAC and Windows Firewall can make your system less secure.`n`n" +
        "Do you want to continue?",
        "System Tweaks Warning",
        [System.Windows.Forms.MessageBoxButtons]::YesNo,
        [System.Windows.Forms.MessageBoxIcon]::Warning
    )
    if ($result -eq [System.Windows.Forms.DialogResult]::Yes) {
        Write-Log "User applied system tweaks"
        Apply-SystemTweaks
        [System.Windows.Forms.MessageBox]::Show("System tweaks applied.","NEFK Tweaker",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Information)
    } else {
        Write-Log "User cancelled system tweaks"
    }
})

$BtnRevertSystem.Add_Click({
    Write-Log "User reverted system tweaks"
    Revert-SystemTweaks
    [System.Windows.Forms.MessageBox]::Show("System tweaks reverted.","NEFK Tweaker",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Information)
})

# ---------- REMOVE APPS TAB ----------
$appsItems = @(
    "Microsoft OneDrive",
    "Microsoft Xbox",
    "Microsoft OneNote",
    "Microsoft LinkedIn",
    "Microsoft Store",
    "Microsoft Edge (Chromium)",
    "Microsoft Edge (Legacy)",
    "Microsoft Teams",
    "Microsoft Skype",
    "Microsoft Solitaire Collection",
    "Microsoft News",
    "Microsoft Weather",
    "Microsoft Maps",
    "Microsoft Photos",
    "Microsoft Camera",
    "Microsoft Calculator",
    "Microsoft Mail & Calendar",
    "Microsoft People",
    "Microsoft Your Phone",
    "Microsoft To Do",
    "Microsoft Get Help",
    "Microsoft Tips",
    "Microsoft Get Started",
    "Microsoft Office Hub",
    "Microsoft Power Automate",
    "Microsoft Family Safety",
    "Microsoft 3D Viewer",
    "Microsoft Paint 3D",
    "Microsoft Mixed Reality Portal",
    "Microsoft Windows Mixed Reality",
    "Microsoft Feedback Hub",
    "Microsoft Windows Security",
    "Microsoft Windows Terminal",
    "Microsoft Windows Media Player",
    "Microsoft Quick Assist",
    "Microsoft Clipchamp",
    "Microsoft Phone Link",
    "Microsoft Outlook",
    "Microsoft Snipping Tool",
    "Microsoft Clock",
    "Microsoft Bing Search",
    "Sound Recorder",
    "Sticky Notes",
    "Web Media Extensions"
)
$appsTooltips = @(
    "Cloud storage",
    "Gaming app",
    "Note app",
    "Social network",
    "App store",
    "Web browser",
    "Old browser",
    "Chat app",
    "Video calls",
    "Card games",
    "News feed",
    "Weather app",
    "Maps app",
    "Photo viewer",
    "Camera app",
    "Calculator",
    "Email client",
    "Contacts app",
    "Phone sync",
    "Task manager",
    "Help center",
    "Tips app",
    "Getting started",
    "Office hub",
    "Automation tool",
    "Parental controls",
    "3D viewer",
    "3D paint",
    "VR portal",
    "VR app",
    "Feedback app",
    "Security app",
    "Terminal app",
    "Media player",
    "Remote assist",
    "Video editor",
    "Phone link",
    "Email client",
    "Screenshot tool",
    "Alarm clock",
    "Search engine",
    "Audio recorder",
    "Note taking",
    "Media codecs"
)
$AppsPanel,$AppsList = New-ChecklistPanel $appsItems $appsTooltips
# Reduce list height to make room for buttons
$AppsList.Height = 350
# Adjust Check All/Uncheck All button positions
$checkAllBtn = $AppsPanel.Controls | Where-Object {$_.Text -eq "Check All"}
$uncheckAllBtn = $AppsPanel.Controls | Where-Object {$_.Text -eq "Uncheck All"}
if ($checkAllBtn) { $checkAllBtn.Location = New-Object System.Drawing.Point(10,360) }
if ($uncheckAllBtn) { $uncheckAllBtn.Location = New-Object System.Drawing.Point(120,360) }
$TabApps.Controls.Add($AppsPanel)

# Add Apply/Revert buttons for Remove Apps tab - add to panel, not tab
$BtnRemoveApps = New-Object System.Windows.Forms.Button
$BtnRemoveApps.Text = "Remove Selected Apps"
$BtnRemoveApps.Size = New-Object System.Drawing.Size(210,25)
$BtnRemoveApps.Location = New-Object System.Drawing.Point(10,400)
$BtnRemoveApps.BackColor = [System.Drawing.Color]::FromArgb(220,20,60)  # Red for removal
$BtnRemoveApps.FlatStyle = 'Flat'
$BtnRemoveApps.ForeColor = 'White'
$BtnRemoveApps.FlatAppearance.BorderSize = 0
$BtnRemoveApps.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
$BtnRemoveApps.Cursor = [System.Windows.Forms.Cursors]::Hand

$BtnRestoreApps = New-Object System.Windows.Forms.Button
$BtnRestoreApps.Text = "Restore All Apps"
$BtnRestoreApps.Size = New-Object System.Drawing.Size(210,25)
$BtnRestoreApps.Location = New-Object System.Drawing.Point(10,430)
$BtnRestoreApps.BackColor = [System.Drawing.Color]::DarkGreen
$BtnRestoreApps.FlatStyle = 'Flat'
$BtnRestoreApps.ForeColor = 'White'
$BtnRestoreApps.FlatAppearance.BorderSize = 0
$BtnRestoreApps.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
$BtnRestoreApps.Cursor = [System.Windows.Forms.Cursors]::Hand

# Add buttons to the panel, not the tab, so they're visible
$AppsPanel.Controls.Add($BtnRemoveApps)
$AppsPanel.Controls.Add($BtnRestoreApps)

# ---------- REMOVE APPS FUNCTIONS ----------
# Universal function to remove AppxPackage properly
function Remove-AppxPackageUniversal {
    param(
        [string[]]$PackageNames,
        [string]$DisplayNamePattern = ""
    )
    
    foreach ($packageName in $PackageNames) {
        try {
            # Remove for current user
            $packages = Get-AppxPackage | Where-Object {$_.Name -eq $packageName -or $_.Name -like "*$packageName*"}
            foreach ($pkg in $packages) {
                Remove-AppxPackage -Package $pkg.PackageFullName -ErrorAction SilentlyContinue
            }
            
            # Remove for all users (requires admin)
            $allUserPackages = Get-AppxPackage -AllUsers | Where-Object {$_.Name -eq $packageName -or $_.Name -like "*$packageName*"}
            foreach ($pkg in $allUserPackages) {
                Remove-AppxPackage -Package $pkg.PackageFullName -AllUsers -ErrorAction SilentlyContinue
            }
        } catch {
            Write-Log "Error removing package $packageName : $_"
        }
    }
    
    # Remove provisioned packages
    if ($DisplayNamePattern) {
        try {
            Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -like "*$DisplayNamePattern*"} | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
        } catch {
            Write-Log "Error removing provisioned package: $_"
        }
    }
}

function Remove-App-0 { # Microsoft OneDrive
    Write-Log "Removing/Disabling Microsoft OneDrive..."
    try {
        # Stop OneDrive process
        Stop-Process -Name OneDrive -Force -ErrorAction SilentlyContinue
        Stop-Process -Name "OneDriveSetup" -Force -ErrorAction SilentlyContinue
        Start-Sleep -Seconds 2
        
        # Try multiple package name variations
        $onedrivePackages = @("Microsoft.OneDrive", "OneDrive", "MicrosoftOneDrive")
        Remove-AppxPackageUniversal -PackageNames $onedrivePackages -DisplayNamePattern "OneDrive"
        
        # Also try direct removal by searching all packages
        Get-AppxPackage | Where-Object {$_.Name -like "*OneDrive*" -or $_.Publisher -like "*OneDrive*"} | ForEach-Object {
            Remove-AppxPackage -Package $_.PackageFullName -ErrorAction SilentlyContinue
        }
        Get-AppxPackage -AllUsers | Where-Object {$_.Name -like "*OneDrive*" -or $_.Publisher -like "*OneDrive*"} | ForEach-Object {
            Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction SilentlyContinue
        }
        
        # Remove provisioned packages
        Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -like "*OneDrive*"} | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
        
        # Also try uninstalling OneDrive setup
        $onedrivePath = "$env:LOCALAPPDATA\Microsoft\OneDrive\OneDriveSetup.exe"
        if (Test-Path $onedrivePath) {
            Start-Process -FilePath $onedrivePath -ArgumentList "/uninstall" -Wait -ErrorAction SilentlyContinue
        }
        
        # Remove OneDrive folder
        $onedriveFolder = "$env:LOCALAPPDATA\Microsoft\OneDrive"
        if (Test-Path $onedriveFolder) {
            Remove-Item -Path $onedriveFolder -Recurse -Force -ErrorAction SilentlyContinue
        }
        
        # Disable OneDrive via registry (prevents it from starting)
        try {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Force | Out-Null
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue
            # Also disable for current user
            New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Force -ErrorAction SilentlyContinue | Out-Null
            Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse -Force -ErrorAction SilentlyContinue
        } catch {
            Write-Log "Could not disable OneDrive via registry: $_"
        }
        
        Write-Log "Microsoft OneDrive removed/disabled"
    } catch {
        Write-Log "Error removing OneDrive: $_"
    }
}

function Remove-App-1 { # Microsoft Xbox
    Write-Log "Removing Microsoft Xbox..."
    try {
        # Stop Xbox processes
        Get-Process | Where-Object {$_.ProcessName -like "*Xbox*"} | Stop-Process -Force -ErrorAction SilentlyContinue
        Stop-Process -Name "XboxApp" -Force -ErrorAction SilentlyContinue
        Stop-Process -Name "XboxGameBar" -Force -ErrorAction SilentlyContinue
        Stop-Process -Name "XboxIdentityProvider" -Force -ErrorAction SilentlyContinue
        Stop-Process -Name "XboxGamingOverlay" -Force -ErrorAction SilentlyContinue
        Start-Sleep -Seconds 3
        
        # Try AppxPackage removal with more package names
        $xboxPackages = @(
            "Microsoft.XboxApp",
            "Microsoft.XboxGameOverlay",
            "Microsoft.XboxGamingOverlay",
            "Microsoft.XboxIdentityProvider",
            "Microsoft.XboxSpeechToTextOverlay",
            "Microsoft.Xbox",
            "Xbox",
            "Microsoft.Xbox.TCUI",
            "Microsoft.XboxGameCallableUI",
            "Microsoft.XboxGamingOverlay",
            "Microsoft.XboxIdentityProvider",
            "Microsoft.XboxApp",
            "Microsoft.GamingApp"
        )
        Remove-AppxPackageUniversal -PackageNames $xboxPackages -DisplayNamePattern "Xbox"
        
        # Also try direct removal by searching all packages - more aggressive
        Get-AppxPackage | Where-Object {
            $_.Name -like "*Xbox*" -or 
            $_.Publisher -like "*Xbox*" -or 
            $_.Name -like "*Gaming*" -or
            $_.DisplayName -like "*Xbox*"
        } | ForEach-Object {
            Write-Log "Found Xbox package: $($_.Name) - $($_.PackageFullName) - DisplayName: $($_.DisplayName)"
            try {
                Remove-AppxPackage -Package $_.PackageFullName -ErrorAction Stop
                Write-Log "Successfully removed: $($_.Name)"
            } catch {
                Write-Log "Failed to remove $($_.Name): $_"
                # Try with AllUsers flag
                try {
                    Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction Stop
                    Write-Log "Successfully removed (AllUsers): $($_.Name)"
                } catch {
                    Write-Log "Failed to remove (AllUsers) $($_.Name): $_"
                }
            }
        }
        
        Get-AppxPackage -AllUsers | Where-Object {
            $_.Name -like "*Xbox*" -or 
            $_.Publisher -like "*Xbox*" -or 
            $_.Name -like "*Gaming*" -or
            $_.DisplayName -like "*Xbox*"
        } | ForEach-Object {
            Write-Log "Found Xbox package (AllUsers): $($_.Name) - $($_.PackageFullName) - DisplayName: $($_.DisplayName)"
            try {
                Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction Stop
                Write-Log "Successfully removed (AllUsers): $($_.Name)"
            } catch {
                Write-Log "Failed to remove (AllUsers) $($_.Name): $_"
            }
        }
        
        # Remove provisioned packages - more aggressive
        Get-AppxProvisionedPackage -Online | Where-Object {
            $_.DisplayName -like "*Xbox*" -or 
            $_.PackageName -like "*Xbox*" -or
            $_.DisplayName -like "*Gaming*"
        } | ForEach-Object {
            Write-Log "Removing provisioned Xbox package: $($_.DisplayName) - $($_.PackageName)"
            try {
                Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName -ErrorAction Stop
                Write-Log "Successfully removed provisioned: $($_.DisplayName)"
            } catch {
                Write-Log "Failed to remove provisioned $($_.DisplayName): $_"
                # Try with DISM
                try {
                    $packageName = $_.PackageName
                    $dismResult = & DISM /Online /Remove-ProvisionedAppxPackage "/PackageName:$packageName" 2>&1
                    Write-Log "DISM result: $dismResult"
                } catch {
                    Write-Log "DISM removal failed: $_"
                }
            }
        }
        
        # Try removing via Get-Package (for traditional installers)
        try {
            $xboxPackages = Get-Package | Where-Object {$_.Name -like "*Xbox*" -or $_.Name -like "*Gaming*"}
            foreach ($pkg in $xboxPackages) {
                Write-Log "Found Xbox package via Get-Package: $($pkg.Name)"
                try {
                    Uninstall-Package -Name $pkg.Name -Force -ErrorAction Stop
                    Write-Log "Successfully uninstalled via Get-Package: $($pkg.Name)"
                } catch {
                    Write-Log "Failed to uninstall via Get-Package $($pkg.Name): $_"
                }
            }
        } catch {
            Write-Log "Get-Package method failed: $_"
        }
        
        # Try removing via winget
        try {
            $wingetApps = @("Microsoft.Xbox", "Xbox", "Xbox Game Bar", "Microsoft Xbox", "Xbox App", "Xbox Gaming Overlay")
            foreach ($app in $wingetApps) {
                try {
                    winget uninstall "$app" --accept-source-agreements --accept-package-agreements --silent -ErrorAction Stop | Out-Null
                    Write-Log "Successfully uninstalled via winget: $app"
                } catch {
                    Write-Log "winget removal failed for ${app}: $_"
                }
            }
        } catch {
            Write-Log "winget removal failed: $_"
        }
        
        # Remove Xbox folders - more paths
        $xboxPaths = @(
            "$env:LOCALAPPDATA\Microsoft\Xbox",
            "$env:PROGRAMDATA\Microsoft\Xbox",
            "$env:APPDATA\Microsoft\Xbox"
        )
        foreach ($path in $xboxPaths) {
            if (Test-Path $path) {
                Write-Log "Removing Xbox folder: $path"
                try {
                    Remove-Item -Path $path -Recurse -Force -ErrorAction Stop
                    Write-Log "Successfully removed folder: $path"
                } catch {
                    Write-Log "Failed to remove folder ${path}: $_"
                    # Try with takeown and icacls
                    try {
                        takeown /F $path /R /D Y 2>&1 | Out-Null
                        icacls $path /grant Administrators:F /T 2>&1 | Out-Null
                        Remove-Item -Path $path -Recurse -Force -ErrorAction SilentlyContinue
                    } catch {
                        Write-Log "Failed to take ownership and remove: $_"
                    }
                }
            }
        }
        
        # Handle wildcard paths separately
        $wildcardPaths = @(
            "$env:LOCALAPPDATA\Packages",
            "$env:PROGRAMFILES\WindowsApps",
            "$env:PROGRAMDATA\Package Cache"
        )
        foreach ($basePath in $wildcardPaths) {
            if (Test-Path $basePath) {
                try {
                    $xboxDirs = Get-ChildItem -Path $basePath -Filter "*Xbox*" -Directory -ErrorAction SilentlyContinue
                    foreach ($dir in $xboxDirs) {
                        Write-Log "Removing Xbox folder: $($dir.FullName)"
                        try {
                            Remove-Item -Path $dir.FullName -Recurse -Force -ErrorAction Stop
                            Write-Log "Successfully removed folder: $($dir.FullName)"
                        } catch {
                            Write-Log "Failed to remove folder $($dir.FullName): $_"
                            # Try with takeown and icacls
                            try {
                                takeown /F $dir.FullName /R /D Y 2>&1 | Out-Null
                                icacls $dir.FullName /grant Administrators:F /T 2>&1 | Out-Null
                                Remove-Item -Path $dir.FullName -Recurse -Force -ErrorAction SilentlyContinue
                            } catch {
                                Write-Log "Failed to take ownership and remove: $_"
                            }
                        }
                    }
                } catch {
                    Write-Log "Failed to search for Xbox folders in ${basePath}: $_"
                }
            }
        }
        
        # Remove from registry - more paths
        try {
            $regPaths = @(
                "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*",
                "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*",
                "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*",
                "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Deprecated\*"
            )
            foreach ($regPath in $regPaths) {
                Get-ItemProperty $regPath -ErrorAction SilentlyContinue | Where-Object {
                    $_.DisplayName -like "*Xbox*" -or 
                    $_.DisplayName -like "*Gaming*"
                } | ForEach-Object {
                    Write-Log "Found Xbox in registry: $($_.DisplayName)"
                    if ($_.UninstallString) {
                        $uninstallCmd = $_.UninstallString
                        if ($uninstallCmd -match '^"(.+)"') {
                            $uninstallExe = $matches[1]
                            $uninstallArgs = $uninstallCmd.Substring($matches[0].Length).Trim()
                            Write-Log "Running uninstaller: $uninstallExe $uninstallArgs /S"
                            Start-Process -FilePath $uninstallExe -ArgumentList "$uninstallArgs /S" -Wait -ErrorAction SilentlyContinue
                        } elseif ($uninstallCmd -match '^(.+\.exe)') {
                            $uninstallExe = $matches[1]
                            Write-Log "Running uninstaller: $uninstallExe /S"
                            Start-Process -FilePath $uninstallExe -ArgumentList "/S" -Wait -ErrorAction SilentlyContinue
                        }
                    }
                }
            }
        } catch {
            Write-Log "Registry removal failed: $_"
        }
        
        # Try MSI uninstall if exists
        try {
            $msiProducts = Get-WmiObject Win32_Product | Where-Object {$_.Name -like "*Xbox*" -or $_.Name -like "*Gaming*"}
            foreach ($product in $msiProducts) {
                Write-Log "Found Xbox MSI product: $($product.Name)"
                try {
                    $product.Uninstall() | Out-Null
                    Write-Log "Successfully uninstalled MSI: $($product.Name)"
                } catch {
                    Write-Log "Failed to uninstall MSI $($product.Name): $_"
                }
            }
        } catch {
            Write-Log "MSI removal failed: $_"
        }
        
        Write-Log "Microsoft Xbox removal completed"
    } catch {
        Write-Log "Error removing Xbox: $_"
    }
}

function Remove-App-2 { # Microsoft OneNote
    Write-Log "Removing Microsoft OneNote..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.Office.OneNote") -DisplayNamePattern "OneNote"
        Write-Log "Microsoft OneNote removed"
    } catch {
        Write-Log "Error removing OneNote: $_"
    }
}

function Remove-App-3 { # Microsoft LinkedIn
    Write-Log "Removing Microsoft LinkedIn..."
    try {
        # Try multiple package name variations
        $linkedInPackages = @("Microsoft.LinkedIn.LinkedIn", "LinkedIn", "Microsoft.LinkedIn")
        Remove-AppxPackageUniversal -PackageNames $linkedInPackages -DisplayNamePattern "LinkedIn"
        # Also try direct removal by searching all packages
        Get-AppxPackage | Where-Object {$_.Name -like "*LinkedIn*" -or $_.Publisher -like "*LinkedIn*"} | ForEach-Object {
            Remove-AppxPackage -Package $_.PackageFullName -ErrorAction SilentlyContinue
        }
        Get-AppxPackage -AllUsers | Where-Object {$_.Name -like "*LinkedIn*" -or $_.Publisher -like "*LinkedIn*"} | ForEach-Object {
            Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction SilentlyContinue
        }
        Write-Log "Microsoft LinkedIn removed"
    } catch {
        Write-Log "Error removing LinkedIn: $_"
    }
}

function Remove-App-4 { # Microsoft Store
    Write-Log "Removing Microsoft Store..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.WindowsStore") -DisplayNamePattern "WindowsStore"
        Write-Log "Microsoft Store removed"
    } catch {
        Write-Log "Error removing Microsoft Store: $_"
    }
}

function Remove-App-5 { # Microsoft Edge (Chromium)
    Write-Log "Removing Microsoft Edge (Chromium)..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.MicrosoftEdge.Stable", "Microsoft.MicrosoftEdge") -DisplayNamePattern "MicrosoftEdge"
        # Also try winget method
        winget uninstall "Microsoft Edge" --accept-source-agreements --accept-package-agreements -ErrorAction SilentlyContinue | Out-Null
        Write-Log "Microsoft Edge (Chromium) removed"
    } catch {
        Write-Log "Error removing Edge: $_"
    }
}

function Remove-App-6 { # Microsoft Edge (Legacy)
    Write-Log "Removing Microsoft Edge (Legacy)..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.MicrosoftEdge") -DisplayNamePattern "MicrosoftEdge"
        Write-Log "Microsoft Edge (Legacy) removed"
    } catch {
        Write-Log "Error removing Edge Legacy: $_"
    }
}

function Remove-App-7 { # Microsoft Teams
    Write-Log "Removing Microsoft Teams..."
    try {
        # Stop Teams processes
        Stop-Process -Name "Teams" -Force -ErrorAction SilentlyContinue
        Stop-Process -Name "ms-teams" -Force -ErrorAction SilentlyContinue
        Stop-Process -Name "Microsoft Teams" -Force -ErrorAction SilentlyContinue
        Get-Process | Where-Object {$_.ProcessName -like "*Teams*"} | Stop-Process -Force -ErrorAction SilentlyContinue
        Start-Sleep -Seconds 2
        
        # Try AppxPackage removal
        $teamsPackages = @("Microsoft.Teams", "MicrosoftTeams", "Teams", "MSTeams")
        Remove-AppxPackageUniversal -PackageNames $teamsPackages -DisplayNamePattern "Teams"
        
        # Also try direct removal by searching all packages
        Get-AppxPackage | Where-Object {$_.Name -like "*Teams*" -or $_.Publisher -like "*Teams*"} | ForEach-Object {
            Write-Log "Found Teams package: $($_.Name) - $($_.PackageFullName)"
            Remove-AppxPackage -Package $_.PackageFullName -ErrorAction SilentlyContinue
        }
        Get-AppxPackage -AllUsers | Where-Object {$_.Name -like "*Teams*" -or $_.Publisher -like "*Teams*"} | ForEach-Object {
            Write-Log "Found Teams package (AllUsers): $($_.Name) - $($_.PackageFullName)"
            Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction SilentlyContinue
        }
        
        # Remove provisioned packages
        Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -like "*Teams*"} | ForEach-Object {
            Write-Log "Removing provisioned Teams package: $($_.DisplayName)"
            Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName -ErrorAction SilentlyContinue
        }
        # Also try direct removal
        Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -like "*Teams*"} | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
        
        # Try removing via Get-Package (for traditional installers)
        try {
            $teamsPackages = Get-Package | Where-Object {$_.Name -like "*Teams*"}
            foreach ($pkg in $teamsPackages) {
                Write-Log "Found Teams package via Get-Package: $($pkg.Name)"
                Uninstall-Package -Name $pkg.Name -Force -ErrorAction SilentlyContinue
            }
        } catch {
            Write-Log "Get-Package method failed: $_"
        }
        
        # Try removing via winget
        try {
            winget uninstall "Microsoft.Teams" --accept-source-agreements --accept-package-agreements -ErrorAction SilentlyContinue | Out-Null
            winget uninstall "Teams" --accept-source-agreements --accept-package-agreements -ErrorAction SilentlyContinue | Out-Null
            winget uninstall "Microsoft Teams" --accept-source-agreements --accept-package-agreements -ErrorAction SilentlyContinue | Out-Null
        } catch {
            Write-Log "winget removal failed: $_"
        }
        
        # Remove Teams folders (both Appx and traditional installation)
        $teamsPaths = @(
            "$env:LOCALAPPDATA\Microsoft\Teams",
            "$env:APPDATA\Microsoft\Teams",
            "$env:PROGRAMFILES\Microsoft\Teams",
            "$env:PROGRAMFILES(X86)\Microsoft\Teams",
            "$env:PROGRAMDATA\Microsoft\Teams",
            "$env:PROGRAMDATA\Microsoft\Windows\Start Menu\Programs\Microsoft Teams.lnk"
        )
        foreach ($path in $teamsPaths) {
            if (Test-Path $path) {
                Write-Log "Removing Teams folder/file: $path"
                Remove-Item -Path $path -Recurse -Force -ErrorAction SilentlyContinue
            }
        }
        
        # Remove from registry and try uninstaller
        try {
            $regPaths = @(
                "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*",
                "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*",
                "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"
            )
            foreach ($regPath in $regPaths) {
                Get-ItemProperty $regPath -ErrorAction SilentlyContinue | Where-Object {$_.DisplayName -like "*Teams*"} | ForEach-Object {
                    Write-Log "Found Teams in registry: $($_.DisplayName)"
                    if ($_.UninstallString) {
                        $uninstallCmd = $_.UninstallString
                        if ($uninstallCmd -match '^"(.+)"') {
                            $uninstallExe = $matches[1]
                            $uninstallArgs = $uninstallCmd.Substring($matches[0].Length).Trim()
                            Write-Log "Running uninstaller: $uninstallExe $uninstallArgs /S"
                            Start-Process -FilePath $uninstallExe -ArgumentList "$uninstallArgs /S" -Wait -ErrorAction SilentlyContinue
                        } elseif ($uninstallCmd -match '^(.+\.exe)') {
                            $uninstallExe = $matches[1]
                            Write-Log "Running uninstaller: $uninstallExe /S"
                            Start-Process -FilePath $uninstallExe -ArgumentList "/S" -Wait -ErrorAction SilentlyContinue
                        }
                    }
                }
            }
        } catch {
            Write-Log "Registry removal failed: $_"
        }
        
        # Try MSI uninstall if exists
        try {
            $msiProducts = Get-WmiObject Win32_Product | Where-Object {$_.Name -like "*Teams*"}
            foreach ($product in $msiProducts) {
                Write-Log "Found Teams MSI product: $($product.Name)"
                $product.Uninstall() | Out-Null
            }
        } catch {
            Write-Log "MSI removal failed: $_"
        }
        
        Write-Log "Microsoft Teams removal completed"
    } catch {
        Write-Log "Error removing Teams: $_"
    }
}

function Remove-App-8 { # Microsoft Skype
    Write-Log "Removing Microsoft Skype..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.SkypeApp") -DisplayNamePattern "Skype"
        Write-Log "Microsoft Skype removed"
    } catch {
        Write-Log "Error removing Skype: $_"
    }
}

function Remove-App-9 { # Microsoft Solitaire Collection
    Write-Log "Removing Microsoft Solitaire Collection..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.MicrosoftSolitaireCollection") -DisplayNamePattern "Solitaire"
        Write-Log "Microsoft Solitaire Collection removed"
    } catch {
        Write-Log "Error removing Solitaire: $_"
    }
}

function Remove-App-10 { # Microsoft News
    Write-Log "Removing Microsoft News..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.BingNews") -DisplayNamePattern "BingNews"
        Write-Log "Microsoft News removed"
    } catch {
        Write-Log "Error removing News: $_"
    }
}

function Remove-App-11 { # Microsoft Weather
    Write-Log "Removing Microsoft Weather..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.BingWeather") -DisplayNamePattern "BingWeather"
        Write-Log "Microsoft Weather removed"
    } catch {
        Write-Log "Error removing Weather: $_"
    }
}

function Remove-App-12 { # Microsoft Maps
    Write-Log "Removing Microsoft Maps..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.WindowsMaps") -DisplayNamePattern "WindowsMaps"
        Write-Log "Microsoft Maps removed"
    } catch {
        Write-Log "Error removing Maps: $_"
    }
}

function Remove-App-13 { # Microsoft Photos
    Write-Log "Removing Microsoft Photos..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.Windows.Photos") -DisplayNamePattern "Photos"
        Write-Log "Microsoft Photos removed"
    } catch {
        Write-Log "Error removing Photos: $_"
    }
}

function Remove-App-14 { # Microsoft Camera
    Write-Log "Removing Microsoft Camera..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.WindowsCamera") -DisplayNamePattern "WindowsCamera"
        Write-Log "Microsoft Camera removed"
    } catch {
        Write-Log "Error removing Camera: $_"
    }
}

function Remove-App-15 { # Microsoft Calculator
    Write-Log "Removing Microsoft Calculator..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.WindowsCalculator") -DisplayNamePattern "Calculator"
        Write-Log "Microsoft Calculator removed"
    } catch {
        Write-Log "Error removing Calculator: $_"
    }
}

function Remove-App-16 { # Microsoft Mail & Calendar
    Write-Log "Removing Microsoft Mail & Calendar..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("microsoft.windowscommunicationsapps") -DisplayNamePattern "communicationsapps"
        Write-Log "Microsoft Mail & Calendar removed"
    } catch {
        Write-Log "Error removing Mail & Calendar: $_"
    }
}

function Remove-App-17 { # Microsoft People
    Write-Log "Removing Microsoft People..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.People") -DisplayNamePattern "People"
        Write-Log "Microsoft People removed"
    } catch {
        Write-Log "Error removing People: $_"
    }
}

function Remove-App-18 { # Microsoft Your Phone
    Write-Log "Removing Microsoft Your Phone..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.YourPhone") -DisplayNamePattern "YourPhone"
        Write-Log "Microsoft Your Phone removed"
    } catch {
        Write-Log "Error removing Your Phone: $_"
    }
}

function Remove-App-19 { # Microsoft To Do
    Write-Log "Removing Microsoft To Do..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.Todos") -DisplayNamePattern "Todos"
        Write-Log "Microsoft To Do removed"
    } catch {
        Write-Log "Error removing To Do: $_"
    }
}

function Remove-App-20 { # Microsoft Get Help
    Write-Log "Removing Microsoft Get Help..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.GetHelp") -DisplayNamePattern "GetHelp"
        Write-Log "Microsoft Get Help removed"
    } catch {
        Write-Log "Error removing Get Help: $_"
    }
}

function Remove-App-21 { # Microsoft Tips
    Write-Log "Removing Microsoft Tips..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.Getstarted") -DisplayNamePattern "Getstarted"
        Write-Log "Microsoft Tips removed"
    } catch {
        Write-Log "Error removing Tips: $_"
    }
}

function Remove-App-22 { # Microsoft Get Started
    Write-Log "Removing Microsoft Get Started..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.Getstarted") -DisplayNamePattern "Getstarted"
        Write-Log "Microsoft Get Started removed"
    } catch {
        Write-Log "Error removing Get Started: $_"
    }
}

function Remove-App-23 { # Microsoft Office Hub
    Write-Log "Removing Microsoft Office Hub..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.MicrosoftOfficeHub") -DisplayNamePattern "OfficeHub"
        Write-Log "Microsoft Office Hub removed"
    } catch {
        Write-Log "Error removing Office Hub: $_"
    }
}

function Remove-App-24 { # Microsoft Power Automate
    Write-Log "Removing Microsoft Power Automate..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.PowerAutomateDesktop") -DisplayNamePattern "PowerAutomate"
        Write-Log "Microsoft Power Automate removed"
    } catch {
        Write-Log "Error removing Power Automate: $_"
    }
}

function Remove-App-25 { # Microsoft Family Safety
    Write-Log "Removing Microsoft Family Safety..."
    try {
        $familyPackages = @("Microsoft.ParentalControls", "Microsoft.Family", "ParentalControls", "FamilySafety")
        Remove-AppxPackageUniversal -PackageNames $familyPackages -DisplayNamePattern "ParentalControls"
        # Also try direct removal by searching all packages
        Get-AppxPackage | Where-Object {$_.Name -like "*Family*" -or $_.Name -like "*Parental*" -or $_.Publisher -like "*Family*"} | ForEach-Object {
            Remove-AppxPackage -Package $_.PackageFullName -ErrorAction SilentlyContinue
        }
        Get-AppxPackage -AllUsers | Where-Object {$_.Name -like "*Family*" -or $_.Name -like "*Parental*" -or $_.Publisher -like "*Family*"} | ForEach-Object {
            Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction SilentlyContinue
        }
        # Remove provisioned packages
        Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -like "*Family*" -or $_.DisplayName -like "*Parental*"} | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
        Write-Log "Microsoft Family Safety removed"
    } catch {
        Write-Log "Error removing Family Safety: $_"
    }
}

function Remove-App-26 { # Microsoft 3D Viewer
    Write-Log "Removing Microsoft 3D Viewer..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.Microsoft3DViewer") -DisplayNamePattern "3DViewer"
        Write-Log "Microsoft 3D Viewer removed"
    } catch {
        Write-Log "Error removing 3D Viewer: $_"
    }
}

function Remove-App-27 { # Microsoft Paint 3D
    Write-Log "Removing Microsoft Paint 3D..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.MSPaint") -DisplayNamePattern "MSPaint"
        Write-Log "Microsoft Paint 3D removed"
    } catch {
        Write-Log "Error removing Paint 3D: $_"
    }
}

function Remove-App-28 { # Microsoft Mixed Reality Portal
    Write-Log "Removing Microsoft Mixed Reality Portal..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.MixedReality.Portal") -DisplayNamePattern "MixedReality"
        Write-Log "Microsoft Mixed Reality Portal removed"
    } catch {
        Write-Log "Error removing Mixed Reality Portal: $_"
    }
}

function Remove-App-29 { # Microsoft Windows Mixed Reality
    Write-Log "Removing Microsoft Windows Mixed Reality..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.MixedReality.Portal") -DisplayNamePattern "MixedReality"
        Write-Log "Microsoft Windows Mixed Reality removed"
    } catch {
        Write-Log "Error removing Windows Mixed Reality: $_"
    }
}

function Remove-App-30 { # Microsoft Feedback Hub
    Write-Log "Removing Microsoft Feedback Hub..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.WindowsFeedbackHub") -DisplayNamePattern "FeedbackHub"
        Write-Log "Microsoft Feedback Hub removed"
    } catch {
        Write-Log "Error removing Feedback Hub: $_"
    }
}

function Remove-App-31 { # Microsoft Windows Security
    Write-Log "Removing Microsoft Windows Security..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.Windows.SecureAssessmentBrowser") -DisplayNamePattern "SecureAssessmentBrowser"
        Write-Log "Microsoft Windows Security removed"
    } catch {
        Write-Log "Error removing Windows Security: $_"
    }
}

function Remove-App-32 { # Microsoft Windows Terminal
    Write-Log "Removing Microsoft Windows Terminal..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.WindowsTerminal") -DisplayNamePattern "WindowsTerminal"
        Write-Log "Microsoft Windows Terminal removed"
    } catch {
        Write-Log "Error removing Windows Terminal: $_"
    }
}

function Remove-App-33 { # Microsoft Windows Media Player
    Write-Log "Removing Microsoft Windows Media Player..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.ZuneMusic", "Microsoft.ZuneVideo") -DisplayNamePattern "Zune"
        Write-Log "Microsoft Windows Media Player removed"
    } catch {
        Write-Log "Error removing Windows Media Player: $_"
    }
}

function Remove-App-34 { # Microsoft Quick Assist
    Write-Log "Removing Microsoft Quick Assist..."
    try {
        # Stop Quick Assist processes
        Stop-Process -Name "QuickAssist" -Force -ErrorAction SilentlyContinue
        Get-Process | Where-Object {$_.ProcessName -like "*QuickAssist*" -or $_.ProcessName -like "*Quick*Assist*"} | Stop-Process -Force -ErrorAction SilentlyContinue
        Start-Sleep -Seconds 2
        
        # Try multiple package name variations
        $quickAssistPackages = @(
            "Microsoft.QuickAssist",
            "Microsoft.Windows.QuickAssist",
            "Microsoft.Windows.AssignedAccessLockApp",
            "QuickAssist",
            "Microsoft.QuickAssist",
            "Microsoft.Windows.QuickAssist"
        )
        Remove-AppxPackageUniversal -PackageNames $quickAssistPackages -DisplayNamePattern "QuickAssist"
        
        # Also try direct removal by searching all packages
        Get-AppxPackage | Where-Object {
            $_.Name -like "*QuickAssist*" -or 
            $_.Name -like "*Quick*Assist*" -or
            $_.Publisher -like "*QuickAssist*" -or
            $_.DisplayName -like "*Quick Assist*" -or
            $_.DisplayName -like "*QuickAssist*"
        } | ForEach-Object {
            Write-Log "Found Quick Assist package: $($_.Name) - $($_.PackageFullName) - DisplayName: $($_.DisplayName)"
            try {
                Remove-AppxPackage -Package $_.PackageFullName -ErrorAction Stop
                Write-Log "Successfully removed: $($_.Name)"
            } catch {
                Write-Log "Failed to remove $($_.Name): $_"
                # Try with AllUsers flag
                try {
                    Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction Stop
                    Write-Log "Successfully removed (AllUsers): $($_.Name)"
                } catch {
                    Write-Log "Failed to remove (AllUsers) $($_.Name): $_"
                }
            }
        }
        
        Get-AppxPackage -AllUsers | Where-Object {
            $_.Name -like "*QuickAssist*" -or 
            $_.Name -like "*Quick*Assist*" -or
            $_.Publisher -like "*QuickAssist*" -or
            $_.DisplayName -like "*Quick Assist*" -or
            $_.DisplayName -like "*QuickAssist*"
        } | ForEach-Object {
            Write-Log "Found Quick Assist package (AllUsers): $($_.Name) - $($_.PackageFullName) - DisplayName: $($_.DisplayName)"
            try {
                Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction Stop
                Write-Log "Successfully removed (AllUsers): $($_.Name)"
            } catch {
                Write-Log "Failed to remove (AllUsers) $($_.Name): $_"
            }
        }
        
        # Remove provisioned packages
        Get-AppxProvisionedPackage -Online | Where-Object {
            $_.DisplayName -like "*QuickAssist*" -or 
            $_.DisplayName -like "*Quick Assist*" -or
            $_.PackageName -like "*QuickAssist*" -or
            $_.PackageName -like "*Quick*Assist*"
        } | ForEach-Object {
            Write-Log "Removing provisioned Quick Assist package: $($_.DisplayName) - $($_.PackageName)"
            try {
                Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName -ErrorAction Stop
                Write-Log "Successfully removed provisioned: $($_.DisplayName)"
            } catch {
                Write-Log "Failed to remove provisioned $($_.DisplayName): $_"
                # Try with DISM
                try {
                    $packageName = $_.PackageName
                    $dismResult = & DISM /Online /Remove-ProvisionedAppxPackage "/PackageName:$packageName" 2>&1
                    Write-Log "DISM result: $dismResult"
                } catch {
                    Write-Log "DISM removal failed: $_"
                }
            }
        }
        
        # Try removing via Get-Package
        try {
            $quickAssistPackages = Get-Package | Where-Object {
                $_.Name -like "*QuickAssist*" -or 
                $_.Name -like "*Quick Assist*"
            }
            foreach ($pkg in $quickAssistPackages) {
                Write-Log "Found Quick Assist package via Get-Package: $($pkg.Name)"
                try {
                    Uninstall-Package -Name $pkg.Name -Force -ErrorAction Stop
                    Write-Log "Successfully uninstalled via Get-Package: $($pkg.Name)"
                } catch {
                    Write-Log "Failed to uninstall via Get-Package $($pkg.Name): $_"
                }
            }
        } catch {
            Write-Log "Get-Package method failed: $_"
        }
        
        # Try removing via winget
        try {
            $wingetApps = @("Microsoft.QuickAssist", "Quick Assist", "Microsoft Quick Assist")
            foreach ($app in $wingetApps) {
                try {
                    winget uninstall "$app" --accept-source-agreements --accept-package-agreements --silent -ErrorAction Stop | Out-Null
                    Write-Log "Successfully uninstalled via winget: $app"
                } catch {
                    Write-Log "winget removal failed for ${app}: $_"
                }
            }
        } catch {
            Write-Log "winget removal failed: $_"
        }
        
        # Remove Quick Assist folders
        $quickAssistPaths = @(
            "$env:LOCALAPPDATA\Microsoft\QuickAssist",
            "$env:PROGRAMDATA\Microsoft\QuickAssist"
        )
        foreach ($path in $quickAssistPaths) {
            if (Test-Path $path) {
                Write-Log "Removing Quick Assist folder: $path"
                try {
                    Remove-Item -Path $path -Recurse -Force -ErrorAction Stop
                    Write-Log "Successfully removed folder: $path"
                } catch {
                    Write-Log "Failed to remove folder ${path}: $_"
                }
            }
        }
        
        # Handle wildcard paths separately
        $wildcardPaths = @(
            "$env:LOCALAPPDATA\Packages",
            "$env:PROGRAMFILES\WindowsApps"
        )
        foreach ($basePath in $wildcardPaths) {
            if (Test-Path $basePath) {
                try {
                    $quickAssistDirs = Get-ChildItem -Path $basePath -Filter "*QuickAssist*" -Directory -ErrorAction SilentlyContinue
                    foreach ($dir in $quickAssistDirs) {
                        Write-Log "Removing Quick Assist folder: $($dir.FullName)"
                        try {
                            Remove-Item -Path $dir.FullName -Recurse -Force -ErrorAction Stop
                            Write-Log "Successfully removed folder: $($dir.FullName)"
                        } catch {
                            Write-Log "Failed to remove folder $($dir.FullName): $_"
                        }
                    }
                } catch {
                    Write-Log "Failed to search for Quick Assist folders in ${basePath}: $_"
                }
            }
        }
        
        # Remove from registry
        try {
            $regPaths = @(
                "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*",
                "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*",
                "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"
            )
            foreach ($regPath in $regPaths) {
                Get-ItemProperty $regPath -ErrorAction SilentlyContinue | Where-Object {
                    $_.DisplayName -like "*Quick Assist*" -or 
                    $_.DisplayName -like "*QuickAssist*"
                } | ForEach-Object {
                    Write-Log "Found Quick Assist in registry: $($_.DisplayName)"
                    if ($_.UninstallString) {
                        $uninstallCmd = $_.UninstallString
                        if ($uninstallCmd -match '^"(.+)"') {
                            $uninstallExe = $matches[1]
                            $uninstallArgs = $uninstallCmd.Substring($matches[0].Length).Trim()
                            Write-Log "Running uninstaller: $uninstallExe $uninstallArgs /S"
                            Start-Process -FilePath $uninstallExe -ArgumentList "$uninstallArgs /S" -Wait -ErrorAction SilentlyContinue
                        } elseif ($uninstallCmd -match '^(.+\.exe)') {
                            $uninstallExe = $matches[1]
                            Write-Log "Running uninstaller: $uninstallExe /S"
                            Start-Process -FilePath $uninstallExe -ArgumentList "/S" -Wait -ErrorAction SilentlyContinue
                        }
                    }
                }
            }
        } catch {
            Write-Log "Registry removal failed: $_"
        }
        
        Write-Log "Microsoft Quick Assist removal completed"
    } catch {
        Write-Log "Error removing Quick Assist: $_"
    }
}

function Remove-App-35 { # Microsoft Clipchamp
    Write-Log "Removing Microsoft Clipchamp..."
    try {
        $clipchampPackages = @("Microsoft.Clipchamp", "Clipchamp", "MicrosoftClipchamp")
        Remove-AppxPackageUniversal -PackageNames $clipchampPackages -DisplayNamePattern "Clipchamp"
        # Also try direct removal by searching all packages
        Get-AppxPackage | Where-Object {$_.Name -like "*Clipchamp*" -or $_.Publisher -like "*Clipchamp*"} | ForEach-Object {
            Remove-AppxPackage -Package $_.PackageFullName -ErrorAction SilentlyContinue
        }
        Get-AppxPackage -AllUsers | Where-Object {$_.Name -like "*Clipchamp*" -or $_.Publisher -like "*Clipchamp*"} | ForEach-Object {
            Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction SilentlyContinue
        }
        # Remove provisioned packages
        Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -like "*Clipchamp*"} | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
        Write-Log "Microsoft Clipchamp removed"
    } catch {
        Write-Log "Error removing Clipchamp: $_"
    }
}

function Remove-App-36 { # Microsoft Phone Link
    Write-Log "Removing Microsoft Phone Link..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.YourPhone") -DisplayNamePattern "YourPhone"
        Write-Log "Microsoft Phone Link removed"
    } catch {
        Write-Log "Error removing Phone Link: $_"
    }
}

function Remove-App-37 { # Microsoft Outlook
    Write-Log "Removing Microsoft Outlook..."
    try {
        # Try multiple package name variations
        $outlookPackages = @("Microsoft.Office.Outlook", "microsoft.office.outlook", "Outlook", "Microsoft.Outlook")
        Remove-AppxPackageUniversal -PackageNames $outlookPackages -DisplayNamePattern "Outlook"
        # Also try direct removal by searching all packages
        Get-AppxPackage | Where-Object {$_.Name -like "*Outlook*" -or $_.Publisher -like "*Outlook*"} | ForEach-Object {
            Remove-AppxPackage -Package $_.PackageFullName -ErrorAction SilentlyContinue
        }
        Get-AppxPackage -AllUsers | Where-Object {$_.Name -like "*Outlook*" -or $_.Publisher -like "*Outlook*"} | ForEach-Object {
            Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction SilentlyContinue
        }
        # Also try removing via winget
        try {
            winget uninstall "Microsoft Outlook" --accept-source-agreements --accept-package-agreements -ErrorAction SilentlyContinue | Out-Null
        } catch {}
        Write-Log "Microsoft Outlook removed"
    } catch {
        Write-Log "Error removing Outlook: $_"
    }
}

function Remove-App-38 { # Microsoft Snipping Tool
    Write-Log "Removing Microsoft Snipping Tool..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.ScreenSketch", "Microsoft.Windows.SnippingTool") -DisplayNamePattern "SnippingTool"
        Write-Log "Microsoft Snipping Tool removed"
    } catch {
        Write-Log "Error removing Snipping Tool: $_"
    }
}

function Remove-App-39 { # Microsoft Clock
    Write-Log "Removing Microsoft Clock..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.WindowsAlarms", "Microsoft.WindowsAlarms") -DisplayNamePattern "WindowsAlarms"
        Write-Log "Microsoft Clock removed"
    } catch {
        Write-Log "Error removing Clock: $_"
    }
}

function Remove-App-40 { # Microsoft Bing Search
    Write-Log "Removing Microsoft Bing Search..."
    try {
        $bingPackages = @("Microsoft.BingSearch", "Microsoft.Bing", "Microsoft.BingNews", "Microsoft.BingWeather")
        Remove-AppxPackageUniversal -PackageNames $bingPackages -DisplayNamePattern "Bing"
        # Also try direct removal
        Get-AppxPackage | Where-Object {$_.Name -like "*Bing*" -and ($_.Name -like "*Search*" -or $_.Name -eq "Microsoft.Bing")} | ForEach-Object {
            Remove-AppxPackage -Package $_.PackageFullName -ErrorAction SilentlyContinue
        }
        Get-AppxPackage -AllUsers | Where-Object {$_.Name -like "*Bing*" -and ($_.Name -like "*Search*" -or $_.Name -eq "Microsoft.Bing")} | ForEach-Object {
            Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction SilentlyContinue
        }
        Write-Log "Microsoft Bing Search removed"
    } catch {
        Write-Log "Error removing Bing Search: $_"
    }
}

function Remove-App-41 { # Sound Recorder
    Write-Log "Removing Sound Recorder..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.WindowsSoundRecorder", "Microsoft.SoundRecorder") -DisplayNamePattern "SoundRecorder"
        # Also try direct removal
        Get-AppxPackage | Where-Object {$_.Name -like "*Sound*" -or $_.Name -like "*Recorder*"} | ForEach-Object {
            if ($_.Name -like "*SoundRecorder*" -or $_.Name -like "*Sound*Recorder*") {
                Remove-AppxPackage -Package $_.PackageFullName -ErrorAction SilentlyContinue
            }
        }
        Get-AppxPackage -AllUsers | Where-Object {$_.Name -like "*Sound*" -or $_.Name -like "*Recorder*"} | ForEach-Object {
            if ($_.Name -like "*SoundRecorder*" -or $_.Name -like "*Sound*Recorder*") {
                Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction SilentlyContinue
            }
        }
        Write-Log "Sound Recorder removed"
    } catch {
        Write-Log "Error removing Sound Recorder: $_"
    }
}

function Remove-App-42 { # Sticky Notes
    Write-Log "Removing Sticky Notes..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.MicrosoftStickyNotes", "Microsoft.StickyNotes") -DisplayNamePattern "StickyNotes"
        # Also try direct removal
        Get-AppxPackage | Where-Object {$_.Name -like "*Sticky*" -or $_.Name -like "*Notes*"} | ForEach-Object {
            if ($_.Name -like "*Sticky*Notes*") {
                Remove-AppxPackage -Package $_.PackageFullName -ErrorAction SilentlyContinue
            }
        }
        Get-AppxPackage -AllUsers | Where-Object {$_.Name -like "*Sticky*" -or $_.Name -like "*Notes*"} | ForEach-Object {
            if ($_.Name -like "*Sticky*Notes*") {
                Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction SilentlyContinue
            }
        }
        Write-Log "Sticky Notes removed"
    } catch {
        Write-Log "Error removing Sticky Notes: $_"
    }
}

function Remove-App-43 { # Web Media Extensions
    Write-Log "Removing Web Media Extensions..."
    try {
        Remove-AppxPackageUniversal -PackageNames @("Microsoft.WebMediaExtensions", "Microsoft.WebpImageExtension", "Microsoft.HEIFImageExtension", "Microsoft.HEVCVideoExtension") -DisplayNamePattern "WebMedia"
        # Also try direct removal
        Get-AppxPackage | Where-Object {$_.Name -like "*WebMedia*" -or $_.Name -like "*Webp*" -or $_.Name -like "*HEIF*" -or $_.Name -like "*HEVC*"} | ForEach-Object {
            Remove-AppxPackage -Package $_.PackageFullName -ErrorAction SilentlyContinue
        }
        Get-AppxPackage -AllUsers | Where-Object {$_.Name -like "*WebMedia*" -or $_.Name -like "*Webp*" -or $_.Name -like "*HEIF*" -or $_.Name -like "*HEVC*"} | ForEach-Object {
            Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction SilentlyContinue
        }
        Write-Log "Web Media Extensions removed"
    } catch {
        Write-Log "Error removing Web Media Extensions: $_"
    }
}

# Function to remove selected apps
function Remove-SelectedApps {
    Write-Log "Removing selected apps..."
    $removedCount = 0
    for ($i=0; $i -lt $AppsList.Items.Count; $i++) {
        if ($AppsList.GetItemChecked($i)) {
            $funcName = "Remove-App-$i"
            if (Get-Command $funcName -ErrorAction SilentlyContinue) {
                & $funcName
                $removedCount++
            }
        }
    }
    Write-Log "Removed $removedCount app(s)"
    return $removedCount
}

# Button handlers for Remove Apps tab
$BtnRemoveApps.Add_Click({
    $result = [System.Windows.Forms.MessageBox]::Show(
        "Are you sure?.`n`n" +
        "Do you want to continue?",
        "Remove Windows Apps",
        [System.Windows.Forms.MessageBoxButtons]::YesNo,
        [System.Windows.Forms.MessageBoxIcon]::Warning
    )
    if ($result -eq [System.Windows.Forms.DialogResult]::Yes) {
        Write-Log "User confirmed app removal"
        $removedCount = Remove-SelectedApps
        if ($removedCount -gt 0) {
            [System.Windows.Forms.MessageBox]::Show(
                "Removed $removedCount app(s) successfully.`n`n" +
                "You may need to restart your computer for changes to take full effect.",
                "NEFK Tweaker",
                [System.Windows.Forms.MessageBoxButtons]::OK,
                [System.Windows.Forms.MessageBoxIcon]::Information
            )
        } else {
            [System.Windows.Forms.MessageBox]::Show(
                "No apps to remove.",
                "NEFK Tweaker",
                [System.Windows.Forms.MessageBoxButtons]::OK,
                [System.Windows.Forms.MessageBoxIcon]::Information
            )
        }
    } else {
        Write-Log "User cancelled app removal"
    }
})

$BtnRestoreApps.Add_Click({
    [System.Windows.Forms.MessageBox]::Show(
        "To restore removed apps, you can:`n`n" +
        "1. Reinstall them from Microsoft Store`n" +
        "2. Use PowerShell: Get-AppxPackage -AllUsers | Install-AppxPackage`n" +
        "3. Reset Windows Store: wsreset.exe`n`n" +
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Information
    )
})

# ---------- APPLY ALL TWEAKS ----------
function Apply-AllTweaks {
    Write-Log "Applying selected tweaks from all tabs..."
    $totalApplied = 0
    
    # Apply selected Interface tweaks
    $interfaceCount = 0
    for ($i=0; $i -lt $InterfaceList.Items.Count; $i++) {
        if ($InterfaceList.GetItemChecked($i)) {
            $funcName = "Apply-InterfaceTweak-$i"
            if (Get-Command $funcName -ErrorAction SilentlyContinue) {
                & $funcName
                $interfaceCount++
                $totalApplied++
            }
        }
    }
    if ($interfaceCount -gt 0) {
        Write-Log "Applied $interfaceCount interface tweak(s)"
    }
    
    # Apply selected Performance tweaks
    $performanceCount = 0
    for ($i=0; $i -lt $PerformanceList.Items.Count; $i++) {
        if ($PerformanceList.GetItemChecked($i)) {
            $funcName = "Apply-PerformanceTweak-$i"
            if (Get-Command $funcName -ErrorAction SilentlyContinue) {
                & $funcName
                $performanceCount++
                $totalApplied++
            }
        }
    }
    if ($performanceCount -gt 0) {
        Write-Log "Applied $performanceCount performance tweak(s)"
    }
    
    # Apply selected Services tweaks
    $servicesCount = 0
    for ($i=0; $i -lt $ServicesList.Items.Count; $i++) {
        if ($ServicesList.GetItemChecked($i)) {
            $funcName = "Apply-ServicesTweak-$i"
            if (Get-Command $funcName -ErrorAction SilentlyContinue) {
                & $funcName
                $servicesCount++
                $totalApplied++
            }
        }
    }
    if ($servicesCount -gt 0) {
        Write-Log "Applied $servicesCount service tweak(s)"
    }
    
    # Apply selected Privacy tweaks
    $privacyCount = 0
    for ($i=0; $i -lt $PrivacyList.Items.Count; $i++) {
        if ($PrivacyList.GetItemChecked($i)) {
            $funcName = "Apply-PrivacyTweak-$i"
            if (Get-Command $funcName -ErrorAction SilentlyContinue) {
                & $funcName
                $privacyCount++
                $totalApplied++
            }
        }
    }
    if ($privacyCount -gt 0) {
        Write-Log "Applied $privacyCount privacy tweak(s)"
    }
    
    # Apply selected System tweaks
    $systemCount = 0
    for ($i=0; $i -lt $SystemList.Items.Count; $i++) {
        if ($SystemList.GetItemChecked($i)) {
            $funcName = "Apply-SystemTweak-$i"
            if (Get-Command $funcName -ErrorAction SilentlyContinue) {
                & $funcName
                $systemCount++
                $totalApplied++
            }
        }
    }
    if ($systemCount -gt 0) {
        Write-Log "Applied $systemCount system tweak(s)"
    }
    
    # Check and install Chrome if checked
    if ($ChkChrome.Checked) {
        Write-Log "Installing Google Chrome..."
        try {
            $wingetCheck = Get-Command winget -ErrorAction SilentlyContinue
            if ($wingetCheck) {
                Start-Process -FilePath "winget" -ArgumentList "install", "Google.Chrome", "--accept-package-agreements", "--accept-source-agreements" -NoNewWindow -Wait
                Write-Log "Google Chrome installation completed"
                $totalApplied++
            } else {
                Write-Log "winget not found, Chrome installation skipped"
            }
        } catch {
            Write-Log "Error installing Google Chrome: $_"
        }
    }
    
    # Check and install AIDA64 if checked
    if ($ChkAIDA64.Checked) {
        Write-Log "Installing AIDA64 Extreme..."
        try {
            $wingetCheck = Get-Command winget -ErrorAction SilentlyContinue
            if ($wingetCheck) {
                Start-Process -FilePath "winget" -ArgumentList "install", "FinalWire.AIDA64.Extreme", "--accept-package-agreements", "--accept-source-agreements" -NoNewWindow -Wait
                Write-Log "AIDA64 Extreme installation completed"
                $totalApplied++
            } else {
                Write-Log "winget not found, AIDA64 installation skipped"
            }
        } catch {
            Write-Log "Error installing AIDA64 Extreme: $_"
        }
    }
    
    # Check and install Firefox if checked
    if ($ChkFirefox.Checked) {
        Write-Log "Installing Firefox..."
        try {
            $wingetCheck = Get-Command winget -ErrorAction SilentlyContinue
            if ($wingetCheck) {
                Start-Process -FilePath "winget" -ArgumentList "install", "Mozilla.Firefox", "--accept-package-agreements", "--accept-source-agreements" -NoNewWindow -Wait
                Write-Log "Firefox installation completed"
                $totalApplied++
            } else {
                Write-Log "winget not found, Firefox installation skipped"
            }
        } catch {
            Write-Log "Error installing Firefox: $_"
        }
    }
    
    # Check and install WinRAR if checked
    if ($ChkWinRAR.Checked) {
        Write-Log "Installing WinRAR..."
        try {
            $wingetCheck = Get-Command winget -ErrorAction SilentlyContinue
            if ($wingetCheck) {
                Start-Process -FilePath "winget" -ArgumentList "install", "RARLab.WinRAR", "--accept-package-agreements", "--accept-source-agreements" -NoNewWindow -Wait
                Write-Log "WinRAR installation completed"
                $totalApplied++
            } else {
                Write-Log "winget not found, WinRAR installation skipped"
            }
        } catch {
            Write-Log "Error installing WinRAR: $_"
        }
    }
    
    Write-Log "Total applied: $totalApplied tweak(s)/installation(s)"
    if ($totalApplied -gt 0) {
        [System.Windows.Forms.MessageBox]::Show("Applied $totalApplied selected tweak(s) successfully.","NEFK Tweaker",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Information)
    } else {
        [System.Windows.Forms.MessageBox]::Show("No tweaks were selected. Please select tweaks from any tab.","NEFK Tweaker",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Information)
    }
}

# ---------- REVERT ALL TWEAKS ----------
function Revert-AllTweaks {
    Write-Log "Reverting ALL tweaks..."
    Revert-InterfaceTweaks
    Revert-PerformanceTweaks
    Revert-ServicesTweaks
    Revert-PrivacyTweaks
    Revert-SystemTweaks
    Write-Log "All tweaks reverted to defaults."
    [System.Windows.Forms.MessageBox]::Show("All tweaks reverted to default values.","NEFK Tweaker",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Information)
}

# ---------- BUTTON HANDLERS ----------
$BtnApply.Add_Click({
    Write-Log "User clicked 'Apply All Tweaks'"
    Apply-AllTweaks
})

$BtnRevert.Add_Click({
    Write-Log "User clicked 'Revert All Tweaks'"
    Revert-AllTweaks
})

$BtnLog.Add_Click({
    if (Test-Path $LogPath) {
        Write-Log "User opened log file."
        Start-Process notepad.exe -ArgumentList $LogPath
    } else {
        [System.Windows.Forms.MessageBox]::Show("Log file not found.","NEFK Tweaker",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Warning)
    }
})

$BtnRestore.Add_Click({
    Write-Log "User requested restore point creation."
    try {
        # Step 1: Enable System Restore service (srservice)
        Write-Log "Step 1: Enabling System Restore service..."
        $srService = Get-Service -Name "srservice" -ErrorAction SilentlyContinue
        if ($srService) {
            # Set service to Automatic startup if disabled
            if ($srService.StartType -eq "Disabled") {
                Set-Service -Name "srservice" -StartupType Automatic -ErrorAction Stop
                Write-Log "System Restore service startup type set to Automatic"
            }
            
            # Start the service if not running
            if ($srService.Status -ne "Running") {
                Start-Service -Name "srservice" -ErrorAction Stop
                Write-Log "System Restore service started"
                # Wait for service to fully start
                Start-Sleep -Seconds 2
            } else {
                Write-Log "System Restore service is already running"
            }
        } else {
            throw "System Restore service (srservice) not found"
        }
        
        # Step 2: Enable System Protection and reserve space
        Write-Log "Step 2: Enabling System Protection and reserving space..."
        $drive = "C:"
        
        # Enable System Protection on C: drive
        try {
            Enable-ComputerRestore -Drive $drive -ErrorAction Stop
            Write-Log "System Protection enabled on $drive"
        } catch {
            # Check if already enabled
            $protection = Get-ComputerRestorePoint -ErrorAction SilentlyContinue
            if ($protection) {
                Write-Log "System Protection is already enabled on $drive"
            } else {
                throw "Failed to enable System Protection: $_"
            }
        }
        
        # Reserve space for System Restore (10 percent of drive, minimum 1GB)
        Write-Log "Reserving disk space for System Restore (10 percent of drive)..."
        try {
            # Use vssadmin to resize shadow storage
            $vssResult = vssadmin Resize ShadowStorage /For=$drive /On=$drive /MaxSize=10% 2>&1
            if ($LASTEXITCODE -eq 0) {
                Write-Log "Successfully reserved 10 percent of disk space for System Restore on $drive"
            } else {
                # Try alternative: set minimum 1GB
                Write-Log "Attempting to set minimum 1GB for shadow storage..."
                vssadmin Resize ShadowStorage /For=$drive /On=$drive /MaxSize=1GB 2>&1 | Out-Null
                Write-Log "Shadow storage space configured"
            }
        } catch {
            Write-Log "Warning: Could not configure shadow storage size, using default settings: $_"
        }
        
        # Wait a moment for everything to be ready
        Write-Log "Waiting for System Restore to be ready..."
        Start-Sleep -Seconds 3
        
        # Step 3: Create restore point
        Write-Log "Step 3: Creating restore point..."
        $desc = "NEFK Tweaker - System Restore Point"
        
        # Verify service is running before creating restore point
        $srService = Get-Service -Name "srservice" -ErrorAction SilentlyContinue
        if ($srService.Status -ne "Running") {
            Start-Service -Name "srservice" -ErrorAction Stop
            Start-Sleep -Seconds 2
        }
        
        Checkpoint-Computer -Description $desc -RestorePointType "MODIFY_SETTINGS" -ErrorAction Stop
        Write-Log "System restore point created successfully: $desc"
        
        [System.Windows.Forms.MessageBox]::Show(
            "System restore point created successfully!`n`n" +
            "Description: $desc`n`n" +
            "Service: Enabled and Running`n" +
            "System Protection: Enabled on C:`n" +
            "Disk Space: Reserved",
            "NEFK Tweaker",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Information
        )
    } catch {
        Write-Log "Failed to create restore point: $_"
        $errorMsg = "Failed to create restore point.`n`nError: $_`n`n" +
                    "Possible reasons:`n" +
                    "- You may need administrator privileges`n" +
                    "- System Restore service may be unavailable`n" +
                    "- Insufficient disk space"
        [System.Windows.Forms.MessageBox]::Show($errorMsg,"NEFK Tweaker",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Warning)
    }
})

# ---------- CHROME AND AIDA64 CHECKBOXES ----------
# Note: These checkboxes are now handled by Apply-AllTweaks function
# They no longer install immediately when checked - installation happens when "Apply All Tweaks" is clicked

# ---------- UI POLISH ----------
$Form.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$Tabs.Font = New-Object System.Drawing.Font("Segoe UI", 10)

# Button visual consistency
$buttons = @($BtnApply, $BtnRevert, $BtnLog, $BtnRestore, $BtnApplyPerf, $BtnRevertPerf, $BtnRemoveApps, $BtnRestoreApps)
foreach ($btn in $buttons) {
    if ($btn -ne $null) {
        $btn.Cursor = [System.Windows.Forms.Cursors]::Hand
    }
}

# ---------- WINDOW ICON ----------
try {
    $iconPath = "$PSScriptRoot\icon.ico"
    if (Test-Path $iconPath) {
        $Form.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($iconPath)
    }
} catch {}

# ---------- SHOW FORM ----------
Write-Log "Launching NEFK Tweaker interface..."
[void]$Form.ShowDialog()
Write-Log "=== NEFK Tweaker closed ==="

