﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="callinviewimage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.callinviewimage" %>


<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Image View</title>
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

    <div class="well">
        <h3><strong>Full image</strong></h3>
        <div class="navbar-right">
            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" runat="server" OnClick="LinkButton1_Click">back</asp:LinkButton>
        </div>
    </div>
    <asp:Image ID="Image1" runat="server" />
    <br/>
    <asp:Button ID="Button1" CssClass="btn btn-default" runat="server" OnClientClick="return confirm('delete this image?');" Text="delete" OnClick="Button1_Click" />
</asp:Content>
