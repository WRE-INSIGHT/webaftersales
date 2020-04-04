<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signaturePage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.signaturePage" %>

<meta name="viewport" content="width=device-width, initial-scale=1">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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
            <div class="row">
                <div class="col-sm-6">
                    
                            <canvas id="myCanvas"></canvas>
                            <input type='hidden' id='myurl' name='myurl' />
                            <input type='hidden' id='myurl1' name='myurl1' />
                            <br />
                            <asp:Button runat="server" CssClass="btn btn-warning" Text="Reset Sign" ID='resetSign' />
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
                        function storeimage1() {
                            var canvas = document.getElementById('myCanvas');
                            var context = canvas.getContext('2d');
                            var dataURL = canvas.toDataURL();

                            var h = document.getElementById('myurl1');
                            h.value = dataURL;

                            //document.getElementById('resetSign').click();
                            //document.getElementById('Image1').src = dataURL;
                        }

                    </script>
                </div>
                <div class="col-sm-6">

                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>


                            <div class="container">
                                <div class="page-header">
                                    <h1>
                                        <small>
                                            <asp:Label ID="Label1" runat="server" Text="Signature Form">
                                            </asp:Label></small></h1>
                                    <div class="navbar-right">
                                        <asp:HyperLink ID="HyperLink1" CssClass="btn btn-default" NavigateUrl="~/AFTERSALESPROJ/reportviewPage.aspx" runat="server" Text="back to report"></asp:HyperLink>
                                    </div>
                                </div>
                                <asp:Panel ID="Panel1" runat="server" Visible="False">
                                    <table class="tbl">
                                        <tr>
                                            <td style="width: 100%">
                                                <asp:TextBox ID="tboxinspector" Height="40" CssClass="form-control" placeholder="Inspected and Assessed by" runat="server"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tboxinspector" Text="*" ForeColor="Red" ValidationGroup="g1"
                                                    ErrorMessage="Inspected and Assessed by is required"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:TextBox ID="tboxinspectordate" Height="40" placeholder="Date" CssClass="form-control" runat="server"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:CompareValidator ID="CompareValidator1" ControlToValidate="tboxinspectordate" ValidationGroup="g1"
                                                    Type="Date" Operator="DataTypeCheck" runat="server" ErrorMessage="Invalid Date" Text="*" ForeColor="Red"></asp:CompareValidator>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="date is required"
                                                    ForeColor="Red" ValidationGroup="g1" ControlToValidate="tboxinspectordate" Text="*"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Button ID="Button2" CssClass="btn btn-primary" ValidationGroup="g1" OnClientClick="storeimage()" runat="server" Text="capture signature" OnClick="Button2_Click" />
                                            </td>
                                        </tr>
                                    </table>

                                </asp:Panel>
                                <asp:Panel ID="Panel2" runat="server" Visible="False">
                                    <table class="tbl">
                                        <tr>
                                            <td style="width: 100%">
                                                <asp:TextBox ID="tboxmonitored" Height="40" placeholder="Assessment Monitored by" CssClass="form-control" runat="server"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="g2" ControlToValidate="tboxmonitored"
                                                    ErrorMessage="Assessment Monitored and Accepted by is required" Text="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:TextBox ID="tboxmonitoreddate" Height="40" CssClass="form-control" placeholder="Date" runat="server"></asp:TextBox></td>
                                            <td>
                                                <asp:CompareValidator ID="CompareValidator2" ControlToValidate="tboxmonitoreddate" ValidationGroup="g2"
                                                    Type="Date" Operator="DataTypeCheck" runat="server" ErrorMessage="Invalid Date" Text="*" ForeColor="Red"></asp:CompareValidator>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="date is required"
                                                    ForeColor="Red" ControlToValidate="tboxmonitoreddate" ValidationGroup="g2" Text="*"></asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Button ID="Button1" CssClass="btn btn-primary" ValidationGroup="g2" OnClientClick="storeimage1()" runat="server" Text="capture signature" OnClick="Button1_Click1" />

                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="g1" CssClass="alert alert-danger" runat="server" />
                                <asp:ValidationSummary ID="ValidationSummary2" ValidationGroup="g2" CssClass="alert alert-danger" runat="server" />
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
