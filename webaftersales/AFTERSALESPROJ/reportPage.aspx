<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="reportPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.reportPage" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div>
        <asp:Label ID="lblproject" runat="server" Text="Project Name" Font-Bold="True" Font-Names="Calibri" Font-Size="25pt" ForeColor="#000099"></asp:Label>
        <br />
        <asp:Label ID="lbladdress" runat="server" Text="Address" Font-Names="Century Gothic" Font-Size="11pt" Font-Strikeout="False" ForeColor="#3366CC"></asp:Label>
        <br />
        <br />
        <asp:Label ID="lblcolor" runat="server" Text="Profile finish" Font-Names="Calibri" Font-Size="12pt" Font-Strikeout="False" ForeColor="#666699"></asp:Label>
        <asp:Label ID="lbljo" runat="server" Text="Job Order No." Font-Names="Segoe UI" Font-Size="15pt" Font-Strikeout="False" ForeColor="#666699"></asp:Label>
         <br />
         <br />
         <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/AFTERSALESPROJ/homePage.aspx">HyperLink</asp:HyperLink>
        <br />
    </div>
</asp:Content>
