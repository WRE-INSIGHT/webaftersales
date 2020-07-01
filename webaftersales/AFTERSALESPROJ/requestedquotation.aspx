<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="requestedquotation.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.requestedquotation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Requested proposal</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>Requested proposal</strong></h3>
    </div>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
</asp:Content>
