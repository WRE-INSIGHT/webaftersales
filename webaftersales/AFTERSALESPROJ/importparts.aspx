<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="importparts.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.importparts" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Parts import</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>Parts import</strong></h3>
        <div class="navbar-right">
            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-default" PostBackUrl="~/AFTERSALESPROJ/quotationitem.aspx">back</asp:LinkButton>
        </div>
    </div>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
    <br />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

            <div class="well">
                <div class="row">
                    <div class="col-sm-6">
                        Article No<br />
                        <asp:TextBox ID="tboxarticle" CssClass="form-control" runat="server"></asp:TextBox><br />
                        Description<br />
                        <asp:TextBox ID="tboxdescription" CssClass="form-control" runat="server"></asp:TextBox><br />
                        %Markup<br />
                        <asp:TextBox ID="tboxmarkup" TextMode="Number" CssClass="form-control" runat="server" AutoPostBack="True" OnTextChanged="tboxunitprice_TextChanged">30</asp:TextBox><br />
                    </div>
                    <div class="col-sm-6">
                        Unit price<br />
                        <asp:TextBox ID="tboxunitprice" TextMode="Number" CssClass="form-control" runat="server" AutoPostBack="True" OnTextChanged="tboxunitprice_TextChanged"></asp:TextBox><br />
                        Qty<br />
                        <asp:TextBox ID="tboxqty" TextMode="Number" CssClass="form-control" runat="server" AutoPostBack="True" OnTextChanged="tboxunitprice_TextChanged"></asp:TextBox><br />
                        Net price<br />
                        <asp:TextBox ID="tboxnetprice" TextMode="Number" CssClass="form-control" runat="server"></asp:TextBox><br />
                    </div>
                </div>
                <asp:ValidationSummary ID="ValidationSummary2" CssClass="alert alert-danger" ValidationGroup="val2" runat="server" />
             
                <asp:Button ID="Button1" runat="server" Text="add" CssClass="btn btn-primary" />
            </div>
            <asp:GridView ID="GridView1" runat="server">
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
