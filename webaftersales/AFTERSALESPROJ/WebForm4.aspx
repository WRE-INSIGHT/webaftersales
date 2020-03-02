<%@ Page Title="" Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="WebForm4.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.WebForm4" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <script src="scripts/sign.js"></script>
    <script>
        $(document).ready(function () {
            $('#myCanvas').sign({
                resetButton: $('#resetSign'),
                lineWidth: 2
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     
<%--    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>--%>
    <%--<ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1" runat="server" PopupControlID="Panel1" TargetControlID="Button2" CancelControlID="Button1"></ajaxToolkit:ModalPopupExtender>--%>
    <asp:Panel ID="Panel1" runat="server">
          
          <canvas id="myCanvas"></canvas>
        <asp:Button ID="Button1" runat="server" Text="Button" />
    </asp:Panel>
    <asp:Button ID="Button2" runat="server" Text="Button" />
</asp:Content>
