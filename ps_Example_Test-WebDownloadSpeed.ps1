##################################
#
# Internet download time tester
#
# MVogwell - 29-05-18
# v1.0
#


	$ErrorActionPreference = "Stop"

	$sWebPageDownload = @("https://download.microsoft.com/download/F/5/A/F5ACBD8D-0630-44DD-851A-2B86F91C5AEC/SAMPLE%20-%20CRM4%20Performance%20and%20Scalability%20Assessment%20of%20Customer%20Implementation.docx","https://download.microsoft.com/download/D/F/E/DFE6362D-7A77-4782-9D73-73FE5977C4EE/Best_Practices_for_Virtualizing_Exchange_Server_2010_with_Windows_Server.docx","https://support.fender.com/hc/en-us/article_attachments/207304866/Passport_P250_manual.pdf")

	$sResults = @()

	Try {
		For($w = 0; $w -lt $sWebPageDownload.length; $w++) {

			write-host "`n`nTesting download of $($sWebPageDownload[$w])" -fore yellow

			$i = 0
			$AverageTimeTaken = 0
			While ($i -lt 3)	{
				$Request = New-Object System.Net.WebClient
				$Request.UseDefaultCredentials = $true
				$Start = Get-Date
				$PageRequest = $Request.DownloadString($sWebPageDownload[$w])
				$TimeTaken = ((Get-Date) - $Start).TotalMilliseconds
				$AverageTimeTaken += $TimeTaken
				$Request.Dispose()
				write-host "...Request to $($sWebPageDownload[$w]) download # $($i+1) took $TimeTaken ms"
				$i ++
			}

			$AverageTimeTaken = $AverageTimeTaken / 3
			write-host "`n... Average time taken: $AverageTimeTaken" -fore green

		}
	}
	Catch {
		write-host "... Unable to access the webpage $($sWebPageDownload[$w])"
	}
	Finally {}


	write-host "`n`nPress any key to finish" -fore yellow
	$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

