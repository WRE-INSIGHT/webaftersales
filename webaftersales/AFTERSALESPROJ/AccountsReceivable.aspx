<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="AccountsReceivable.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.AccountsReceivable" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Accounts Receivable</title>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <div style="background-color: whitesmoke">


        <div class="well" style="background-color: white;">
            <h2>Accounts receivable</h2>
            <div class="row">
                <div class="col-sm-2">
                    <div class="input-group">
                        <asp:CheckBox ID="CheckBox1" CssClass="form-control" runat="server" Text="Include Paid" />
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="input-group">
                        <div class="input-group-addon">
                            BEGIN
                        </div>
                        <asp:TextBox ID="tboxSdate" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="input-group">
                        <div class="input-group-addon">
                            END
                        </div>
                        <asp:TextBox ID="tboxEdate" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="input-group">
                        <div class="input-group-addon">
                            search
                        </div>
                        <asp:TextBox ID="tboxsearchkey" CssClass="form-control" runat="server"></asp:TextBox>
                        <div class="input-group-btn">
                            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" runat="server" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>


        </div>
        <asp:Panel ID="Panel1" ScrollBars="Auto" runat="server">
            <asp:GridView ID="GridView1" Width="100%" RowStyle-Wrap="false" runat="server" EmptyDataText="Empty" AllowPaging="True" PageSize="25" AutoGenerateColumns="False" GridLines="None" OnPageIndexChanging="GridView1_PageIndexChanging" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1">
                <Columns>
                    <asp:TemplateField HeaderText="Particulars" HeaderStyle-BackColor="#2b760a" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="pnl">
                        <ItemTemplate>
                            <div>
                                <span style="width: 75%">
                                    <asp:Label ID="Label5" Font-Bold="true" runat="server" Text='<%# Bind("ASENO") %>'></asp:Label>
                                </span>
                                <br />
                                <span style="width: 75%">
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Project") %>'></asp:Label>
                                </span>
                                <br />
                                <div class="text-muted" style="width: 75%">
                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("address") %>'></asp:Label>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Receivable" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="pnl">
                        <ItemTemplate>
                            <div class="text-right">
                                <span class="text-success">PHP
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("actualprice") %>'></asp:Label>
                                </span>
                                <br />
                                <span class="">
                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("DATE") %>'></asp:Label>
                                </span>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Payment status" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="pnl">
                        <ItemTemplate>
                            <div class="text-right">
                                <span>PHP
                                <asp:Label ID="Label7" runat="server" Text='<%# Bind("payment") %>'></asp:Label><br />
                                    <span class='<%# Eval("payment_status").ToString() == "Unpaid" ? "text-danger" : "text-success" %>'>-<asp:Label ID="Label6" runat="server" Text='<%# Bind("payment_status") %>'></asp:Label>-</span>
                                </span>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />
                <PagerSettings PageButtonCount="8" Position="TopAndBottom" />
                <EmptyDataTemplate>
                    <div class="alert alert-info">
                        <h3><strong>Empty Table!</strong>
                        </h3>
                    </div>
                </EmptyDataTemplate>
                <EditRowStyle BorderStyle="None" BorderWidth="0px" />
                <PagerStyle CssClass="GridPager" HorizontalAlign="Right" BackColor="#C6C3C6" ForeColor="Black" />
                <RowStyle BackColor="#DEDFDE" ForeColor="Black" />
                <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#594B9C" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#33276A" />
            </asp:GridView>
            <br />
            <h3>
                <div style="padding: 20px; margin: 20px; border-left: 5px solid red; border-radius: 5px; background-color: white;">
                    <span class="text-muted">Accounts:
                    </span>
                    <span class="pull-right text-right text-success">
                        <asp:Label ID="lblTotalRowCount" Font-Bold="true" runat="server" Text="Label"></asp:Label><br />
                        PHP
                    <asp:Label ID="lblTotalAmount" Font-Bold="true" runat="server" Text="Label"></asp:Label>
                    </span>
                    <br />
                    <span class="text-muted">Total Amount:
                    </span>
                </div>
            </h3>
            <br />
            <br />
        </asp:Panel>
    </div>
</asp:Content>

