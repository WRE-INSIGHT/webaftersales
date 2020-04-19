<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="addservicing.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.addservicing" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>manage schedule</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-header">
        <h2>
            <strong>
                <asp:Label ID="lblproject" runat="server" Text="Project Name"></asp:Label></strong><br />
            <small>
                <asp:Label ID="lbladdress" runat="server" Text="Address"></asp:Label></small></h2>

        <div class="navbar-right">
            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" PostBackUrl="~/AFTERSALESPROJ/CallinPage.aspx" runat="server">back</asp:LinkButton>
        </div>

    </div>
    <h4><strong>manage schedule</strong></h4>
    <br />
    <div class="form-group">
        Date<br />
        <asp:TextBox ID="servicingdate" CssClass="form-control" runat="server"></asp:TextBox><br />
        Remarks<br />
        <asp:TextBox ID="remarks" CssClass="form-control" runat="server"></asp:TextBox><br />
        <asp:Button ID="submitbtn"  CssClass="btn btn-primary" runat="server" Text="submit" OnClick="submitbtn_Click" />
        <asp:Button ID="cancelbtn" CssClass="btn btn-default" runat="server" Text="cancel" />
        <br />
        <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup ="val1" CssClass="alert alert-danger" runat="server" />
    </div>
    <asp:GridView ID="GridView1" AllowPaging="true" runat="server"></asp:GridView>
</asp:Content>
