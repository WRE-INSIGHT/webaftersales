<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FRMsignature.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.WebForm2" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="css/CSSfrmsignature.css" rel="stylesheet" />
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
    </style>
    <script>

    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Sign here..." Font-Bold="True" Font-Names="Calibri" Font-Size="35pt" Font-Strikeout="False" ForeColor="#3333FF"></asp:Label>
            <br />
            <canvas id="myCanvas"></canvas>
            <input type='hidden' id='myurl' name='myurl' />
            <input type='hidden' id='myurl1' name='myurl1' />
            <br />
            <asp:Button runat="server" Text="Reset Sign" ID='resetSign' />
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
        <br />
        <br />
        <asp:ScriptManager ID="ScriptManager2" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table>
                    <tr>
                        <td>
                            <asp:Button ID="Button2" CssClass="btnsubmit" ValidationGroup="g1" OnClientClick="storeimage()" runat="server" Text="capture signature" OnClick="Button2_Click" />
                        </td>
                        <td>
                            <asp:Label ID="Label3" runat="server" Text="Inspected and Assessed by:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="tboxinspector" CssClass="tboxinput" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tboxinspector" Text="*" ForeColor="Red" ValidationGroup="g1"
                                ErrorMessage="Inspected and Assessed by is required"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:Label ID="Label2" runat="server" Text="Date"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="tboxinspectordate" CssClass="tboxinput" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:CompareValidator ID="CompareValidator1" ControlToValidate="tboxinspectordate" ValidationGroup="g1"
                                Type="Date" Operator="DataTypeCheck" runat="server" ErrorMessage="Invalid Date" Text="*" ForeColor="Red"></asp:CompareValidator>
                        </td>  
                    </tr>
                    <tr>
                        <td>
                            <asp:Button ID="Button1" CssClass="btnsubmit" ValidationGroup="g2" OnClientClick="storeimage1()" runat="server" Text="capture signature" OnClick="Button1_Click1" />
                        </td>
                        <td>
                            <asp:Label ID="Label4" runat="server" Text="Assessment Monitored by:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="tboxmonitored" CssClass="tboxinput" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="g2" ControlToValidate="tboxmonitored"
                                ErrorMessage="Assessment Monitored and Accepted by is required" Text="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:Label ID="Label5" runat="server" Text="Date"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="tboxmonitoreddate" CssClass="tboxinput" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:CompareValidator ID="CompareValidator2" ControlToValidate="tboxmonitoreddate" ValidationGroup="g2"
                                Type="Date" Operator="DataTypeCheck" runat="server" ErrorMessage="Invalid Date" Text="*" ForeColor="Red"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <asp:ValidationSummary ID="ValidationSummary1" ForeColor="red" ValidationGroup="g1" runat="server" />
                            <asp:ValidationSummary ID="ValidationSummary2" ForeColor="red" ValidationGroup="g2" runat="server" />
                        </td>
                    </tr>
                </table>
                <br />

            </ContentTemplate>
        </asp:UpdatePanel>

    </form>
</body>
</html>
