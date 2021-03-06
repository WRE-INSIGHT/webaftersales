﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="reportPhotos.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.reportPhotos" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Photos</title>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <div class="well">
        <h3><strong>Photos</strong></h3>
        <div class="navbar-right">
            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" runat="server" OnClick="LinkButton1_Click">back</asp:LinkButton>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Site Photos
        </div>
        <div class="panel-body">
            <asp:Panel ID="Panel3" runat="server">
                <div class="navbar-left">
                    <label class="btn btn-default">
                        <span><strong>Upload Image</strong></span>
                        <asp:FileUpload ID="FileUpload1" runat="server" AllowMultiple="True"></asp:FileUpload>
                    </label>
                </div>
                <div class="navbar-right">
                    <asp:Button ID="Button1" runat="server" Text="Upload Image" ValidationGroup="g1" CssClass="btn btn-default" OnClick="Button1_Click" />
                </div>
            </asp:Panel>
            <br />
            <br />

            <asp:Panel ID="Panel2" runat="server">
                <div class="alert alert-danger">
                    <asp:Label ID="errorlbl" runat="server" Text=""></asp:Label>
                </div>
            </asp:Panel>

        </div>
        <asp:Panel ID="Panel1" runat="server" BorderStyle="None" BackColor="#CCCCCC">
        </asp:Panel>
        <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>

        <div class="panel-footer">
        </div>
    </div>



</asp:Content>
