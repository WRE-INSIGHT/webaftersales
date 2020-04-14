<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="WebForm5.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.WebForm5" %>

<asp:Content ID ="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <asp:FileUpload ID="FileUpload1" runat="server" />
        <asp:Button ID="Button1" runat="server" Text="Upload Image" OnClick="Button1_Click" />
        <asp:Literal ID="Literal1" runat="server"></asp:Literal>
        <br />
        <br />
        <asp:Panel ID="Panel1" runat="server" BorderStyle="Dashed">
        </asp:Panel>
</asp:Content>
     
