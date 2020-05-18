<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="quotationsummary.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.quotationsummary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quotation</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>Quotation</strong></h3>
    </div>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />

    <div class="input-group">
        <asp:TextBox ID="searchkey" runat="server" CssClass="form-control"></asp:TextBox>
        <div class="input-group-btn">
            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" runat="server" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
        </div>
    </div>
    <br />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
                <asp:GridView ID="GridView1" CssClass="table" runat="server" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1">
                    <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" Wrap="False" />
                    <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
                    <RowStyle BackColor="#DEDFDE" ForeColor="Black" Wrap="False" />
                    <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#594B9C" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#33276A" />
                </asp:GridView>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
