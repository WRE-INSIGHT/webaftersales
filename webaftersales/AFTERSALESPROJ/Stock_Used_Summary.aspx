<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="Stock_Used_Summary.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.Stock_Used_Summary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Stock Used Summary</title>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="well">
            <h2>Stock Used Summary</h2>
        </div>
        <div class="well">
            <div class="row">
                <div class="col-sm-6"></div>
                <div class="col-sm-6">
                    <span>Stock Used</span>
                    <div class="input-group">
                        <asp:DropDownList ID="ddlStockUsed" CssClass="form-control" runat="server">
                            <asp:ListItem></asp:ListItem>
                            <asp:ListItem>Mesh with tube</asp:ListItem>
                            <asp:ListItem>Plisse Cord</asp:ListItem>
                            <asp:ListItem>Zigzag/Magnum Cord</asp:ListItem>
                            <asp:ListItem>Caterpillar</asp:ListItem>
                        </asp:DropDownList>
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-primary" OnClick="btnSearch_Click">Search</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div style="overflow-x: auto">
            <asp:GridView ID="gv" runat="server" AutoGenerateColumns="false" CssClass="table" Width="100%" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1" GridLines="Both">
                <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />
                <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
                <RowStyle BackColor="#DEDFDE" ForeColor="Black" />
                <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#594B9C" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#33276A" />
                <Columns>
                    <asp:TemplateField HeaderText="PROJECT">
                        <ItemTemplate>
                            <div style="min-width: 370px;">
                                <span style="font-size: small"><%# Eval("PROJECT").ToString() %></span><br />
                                <span style="font-size: smaller"><%# Eval("ADDRESS").ToString() %></span><br />
                                <span style="font-size: smaller" class="text-info"><%# Eval("JO").ToString() %></span>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ITEM_DESCRIPTION">
                        <ItemTemplate>
                            <div>
                                <span style="font-size: small"><%# Eval("LOCATION").ToString() %></span><br />
                                <span style="font-size: smaller"><%# Eval("KNO").ToString() %></span> / 
                            <span style="font-size: smaller"><%# Eval("ITEMNO").ToString() %></span><br />
                                <span style="font-size: smaller"><%# Eval("ITEM_DESCRIPTION").ToString() %></span>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="STOCK USED">
                        <ItemTemplate>
                            <div style="min-width: 370px;">
                                <span style="font-size: small"><%# Eval("STOCK_USED").ToString() %></span><br />
                                <span style="font-size: smaller"><%# Eval("MEASUREMENT").ToString() %></span><br />
                                <span style="font-size: smaller"><%# Eval("QUANTITY").ToString() %></span>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
