<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="invalidaccessPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.invalidaccessPage" %>

<asp:Content ID ="Content1" runat="server" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1">
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <div class="container">
        <div class="jumbotron">
            <h1>
                <strong>Invalid Access!</strong><small>unable to access this page</small>
            </h1>
        </div>
    </div>
</asp:Content>