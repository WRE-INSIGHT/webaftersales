<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.WebForm2" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <script src="scripts/sign.js"></script>

    <script>
        $(document).ready(function () {
            $('#myCanvas').sign({
                resetButton: $('#resetSign'),
                lineWidth: 10
            });
        });
    </script>
    <style>
        #myCanvas {
            border: 4px solid #444;
            border-radius: 15px;
        }
    </style>
    <script>

    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <canvas id="myCanvas"></canvas>
            <asp:Image ID="Image1" runat="server" />
            <input type="button" value="Reset" id='resetSign' />
            <script>
                function storeimage() {
                    var canvas = document.getElementById('myCanvas');
                    var context = canvas.getContext('2d');
                    var dataURL = canvas.toDataURL();
                    document.getElementById('Image1').src = dataURL;
                }
            </script>
        </div>
        <br />
        <br />
        <asp:Button ID="Button1" OnClientClick="storeimage()" runat="server" Text="Button" />
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="629px">
            <LocalReport ReportPath="AFTERSALESPROJ\report\Report1.rdlc">
            </LocalReport>
        </rsweb:ReportViewer>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

    </form>
</body>
</html>
