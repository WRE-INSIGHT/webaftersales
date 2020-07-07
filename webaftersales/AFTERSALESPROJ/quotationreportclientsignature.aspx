<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="quotationreportclientsignature.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.quotationreportclientsignature" %>

<meta name="viewport" content="width=device-width, initial-scale=1">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Report Signature</title>
    <script src="../Scripts/bootstrap.js"></script>
    <link href="../Content/bootstrap.css" rel="stylesheet" />
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <script src="../Scripts/bootstrap.min.js"></script>
    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <script src="scripts/sign.js"></script>
    <script>
        $(document).ready(function () {
            $('#myCanvas').sign({
                resetButton: $('#resetSign'),
                lineWidth: 5
            });
        });
    </script>
    <style>
        #myCanvas {
            border: 4px solid #444;
            border-radius: 1px;
        }

        .tbl td {
            padding-bottom: 10px;
        }
    </style>
    <script>

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="container-fluid">


            <canvas id="myCanvas"></canvas>
            <input type='hidden' id='myurl' name='myurl' />
            <input type='hidden' id='myurl1' name='myurl1' />
            <br />

            <br />
            <br />
            <br />


            <script>
                function successfulmessage() {
                    alert('Signature captured successfully!');
                }
                function storeimage() {
                    var canvas = document.getElementById('myCanvas');
                    var context = canvas.getContext('2d');
                    var dataURL = canvas.toDataURL();
                    var h = document.getElementById('myurl');
                    h.value = dataURL;

                    //document.getElementById('resetSign').click();
                    //document.getElementById('Image1').src = dataURL;
                }


            </script>
            <br />
            <div class="container well">
                Full-name:<br />
                <asp:TextBox ID="tboxfullname" CssClass="form-control" Width="300" placeholder="Ful-name" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tboxfullname" Text="*" ForeColor="Red" ValidationGroup="g1"
                    ErrorMessage="Your full name is required!"></asp:RequiredFieldValidator><br />
                <asp:Button runat="server" Width="100" CssClass="btn btn-danger" Text="Reset Sign" ID='resetSign' />
                <asp:LinkButton ID="LinkButton2" Width="100" CssClass="btn btn-success" OnClientClick="storeimage()" ValidationGroup="g1" runat="server" OnClick="LinkButton2_Click">Save Sign</asp:LinkButton>
                <asp:LinkButton ID="LinkButton1" Width="100" CssClass="btn btn-default" runat="server" OnClick="LinkButton1_Click">Back</asp:LinkButton>
            </div>
    </form>
</body>
</html>
