function claude-mem {
    param ([string]$action)

    $path = "C:\Users\<username>\.claude\plugins\marketplaces\thedotmack"

    switch ($action) {
        "start" {
            Push-Location $path
            npm run worker:start
            Pop-Location
        }
        "stop" {
            Push-Location $path
            npm run worker:stop
            Pop-Location
        }
        "status" {
            Push-Location $path
            npm run worker:status
            Pop-Location
        }
        default {
            Write-Host "Usage: claude-mem start | stop | status"
        }
    }
}