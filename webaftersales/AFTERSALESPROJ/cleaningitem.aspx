<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="cleaningitem.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.cleaningitem" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Cleaning Item</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>Cleaning Item</strong></h3>
        <div class="navbar-right">
            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" PostBackUrl="~/AFTERSALESPROJ/cleaningpage.aspx" runat="server">back</asp:LinkButton>
        </div>
    </div>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="panel panel-default">
        <div class="panel-heading">
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    Location<br />
                    <asp:TextBox ID="tboxlocation" CssClass=" form-control" runat="server"></asp:TextBox><br />
                    Area<br />
                    <asp:TextBox ID="tboxarea" TextMode="Number" CssClass=" form-control" runat="server"></asp:TextBox>
                </div>
                <div class="col-sm-6">
                    Unit Price<br />
                    <asp:TextBox ID="tboxunitprice" TextMode="Number" CssClass=" form-control" runat="server"></asp:TextBox><br />
                    Qty<br />
                    <asp:TextBox ID="tboxqty" TextMode="Number" CssClass=" form-control" runat="server"></asp:TextBox>
                </div>
            </div>
            <br />
            <asp:LinkButton ID="LinkButton2" CssClass="btn btn-primary" runat="server" OnClick="LinkButton2_Click">add</asp:LinkButton>
        </div>
        <div class="panel-footer">
        </div>
    </div>

    <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridView1" runat="server" CssClass="table">
                    <RowStyle Wrap="false" />
                    <HeaderStyle Wrap="false" />
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
    </asp:Panel>

</asp:Content>
