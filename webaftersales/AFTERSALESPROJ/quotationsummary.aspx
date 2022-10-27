<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="quotationsummary.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.quotationsummary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quotation Payment Monitoring</title>
    <style>
        .Green {
            border-left: solid 5px green;
            padding-left: 5px;
        }

        .Red {
            border-left: solid 5px red;
            padding-left: 5px;
        }

        .Yellow {
            border-left: solid 5px yellow;
            padding-left: 5px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>Aftersales Payment Monitoring</strong></h3>
    </div>
    <div class="well">
        <div class="row">
            <div class="col-sm-4">
                <br />
                <table>
                    <tr>
                        <td style="border-top: solid 10px red; padding-top: 5px; width: 100px; text-align: center;">Unpaid
                        </td>
                        <td style="border-top: solid 10px yellow; padding-top: 5px; width: 100px; text-align: center;">Incomplete
                        </td>
                        <td style="border-top: solid 10px green; padding-top: 5px; width: 100px; text-align: center;">Paid
                        </td>
                    </tr>
                </table>
            </div>
            <div class="col-sm-2">
                Payment Status:
                <asp:DropDownList ID="ddlPaymentStatus" CssClass="form-control" runat="server">
                    <asp:ListItem>All</asp:ListItem>
                    <asp:ListItem>Unpaid</asp:ListItem>
                    <asp:ListItem>Incomplete</asp:ListItem>
                    <asp:ListItem>Paid</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-sm-6">
                Search Key:
                <div class="input-group">
                    <asp:TextBox ID="searchkey" runat="server" CssClass="form-control"></asp:TextBox>
                    <div class="input-group-btn">
                        <asp:LinkButton ID="LinkButton1" CssClass="btn btn-primary" runat="server" OnClick="LinkButton1_Click">Search</asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
                <asp:GridView ID="GridView1" GridLines="Vertical" CssClass="table" Width="100%" runat="server" AllowPaging="True" AutoGenerateColumns="False" OnRowCommand="GridView1_RowCommand" OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="25" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:TemplateField HeaderText="Project">
                            <ItemTemplate>
                                <asp:Panel ID="pnl" runat="server" CssClass='<%# Eval("Payment_Status").ToString() == "Paid" ? "Green" : Eval("Payment_Status").ToString() == "Incomplete" ? "Yellow" : "Red" %>'>
                                    <asp:LinkButton ID="LinkButton2" ForeColor="Black" runat="server" Font-Bold="true" Font-Size="Small" CommandName="showquotation" Text='<%# Bind("project") %>'></asp:LinkButton><br />
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:Label ID="g1lblfulladd" runat="server" Font-Size="X-Small" Text='<%# Bind("fulladd") %>'></asp:Label><br />
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:Label ID="lbljo" runat="server" Font-Size="XX-Small" Text='<%# Bind("jo") %>'></asp:Label>
                                </asp:Panel>
                                <asp:Panel ID="Panel2" runat="server" ScrollBars="Auto">
                                    <asp:GridView ID="GridView2" Visible="false" Font-Size="Smaller" OnRowCommand="GridView2_RowCommand" AutoGenerateColumns="false" CssClass="table table-striped" GridLines="Both" runat="server">
                                        <Columns>
                                            <asp:TemplateField HeaderText="ase#">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblcin" runat="server" Visible="false" Text='<%# Bind("cin") %>'></asp:Label>
                                                    <asp:Label ID="lblsid" runat="server" Visible="false" Text='<%# Bind("sid") %>'></asp:Label>
                                                    <asp:Label ID="lblquotationtype" runat="server" Visible="false" Text='<%# Bind("quotationtype") %>'></asp:Label>
                                                    <asp:Label ID="lblmiscellaneous" runat="server" Visible="false" Text='<%# Bind("miscellaneous") %>'></asp:Label>
                                                    <asp:Label ID="lblaseno" runat="server" Text='<%# Bind("aseno") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="quotation date">
                                                <ItemTemplate>
                                                    <asp:Label ID="datelbl" runat="server" Text='<%# Bind("qdate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="bill amount" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("bill_amount") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="discounted price" ItemStyle-HorizontalAlign="Right">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("discounted_price") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="waived">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label7" runat="server" Text='<%# Bind("waived") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                               <asp:TemplateField HeaderText="lock">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label7" runat="server" Text='<%# Eval("lock").ToString() == "1" ? "yes" : "no" %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="LinkButton3" CommandName="myquotation" runat="server">view</asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle Wrap="false" />
                                        <RowStyle Wrap="false" />
                                    </asp:GridView>
                                </asp:Panel>

                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Bill Amount" ItemStyle-HorizontalAlign="Right">
                            <ItemTemplate>
                                <asp:Label ID="g1lblbillamaount" runat="server" Font-Size="Small" Text='<%# Bind("bill_amount") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Discounted Price" ItemStyle-HorizontalAlign="Right">
                            <ItemTemplate>
                                <asp:Label ID="g1lbldiscountedprice" runat="server" Font-Size="Small" Text='<%# Bind("discounted_price") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Payment" ItemStyle-BackColor="White" ItemStyle-HorizontalAlign="Right">
                            <ItemTemplate>
                                <asp:Label ID="g1lblpayment" runat="server" Font-Size="Small" CssClass="text-success" Text='<%# Bind("Payment") %>'></asp:Label><br />
                                -<asp:Label ID="g1lblpaymentstatus" runat="server" Font-Size="X-Small" Text='<%# Bind("Payment_Status") %>'></asp:Label>-
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Balance" ItemStyle-BackColor="White" ItemStyle-HorizontalAlign="Right">
                            <ItemTemplate>
                                <asp:Label ID="g1lblbalance" runat="server" CssClass='<%#Eval("Payment_Status").ToString() == "Paid" ? "text-success" : "text-danger" %>' Font-Size="Small" Text='<%# Bind("Balance") %>'></asp:Label>

                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="alert alert-danger">
                            <h2><strong>Empty Table!</strong>
                                <small>0 result found</small>
                            </h2>
                        </div>
                    </EmptyDataTemplate>
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                    <PagerStyle CssClass="GridPager" HorizontalAlign="Left" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#0000A9" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#000065" />
                    <HeaderStyle Wrap="False" />
                    <PagerSettings PageButtonCount="15" Position="TopAndBottom" />
                </asp:GridView>
                <asp:Label ID="lblRowNum" runat="server" Font-Size="Large" Text="Results"></asp:Label>
                <br />
                <br />
                <div style="padding: 20px; border-radius: 5px; background-color: white; min-width: 450px; background-color: aliceblue;">
                    <h3>Summary</h3>
                    <table style="width: 100%; font-size: x-large" border="1">
                        <tr>
                            <td><span>Bill Amount:</span></td>
                            <td style="text-wrap: none; text-align: right;">
                                <asp:Label ID="lblbill_amount_summary" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <td><span>Discounted Price:</span></td>
                            <td style="text-wrap: none; text-align: right;">
                                <asp:Label ID="lbldiscounted_price_summary" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <td><span>Collected Amount:</span></td>
                            <td style="text-wrap: none; text-align: right;">
                                <asp:Label ID="lblpayment_summary" CssClass="text-success" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <td><span>Balance:</span></td>
                            <td style="text-wrap: none; text-align: right;">
                                <asp:Label ID="lblbalance_summary" CssClass="text-danger" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                    </table>
                </div>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
