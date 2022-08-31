<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="quotationsummary.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.quotationsummary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quotation Payment Status</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>Quotation Payment Status</strong></h3>
        <div class="input-group">
            <asp:TextBox ID="searchkey" runat="server" CssClass="form-control"></asp:TextBox>
            <div class="input-group-btn">
                <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" runat="server" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
            </div>
        </div>
    </div>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
                <asp:GridView ID="GridView1" GridLines="None" runat="server" AllowPaging="True" AutoGenerateColumns="False" OnRowCommand="GridView1_RowCommand" OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="25">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <div class="panel panel-success">
                                    <div class="panel-heading">
                                    </div>
                                    <div class="panel-body">
                                        <asp:Label ID="Label2" runat="server" Font-Size="Large" Text='<%# Bind("project") %>'></asp:Label><br />
                                        <asp:Label ID="Label3" runat="server" Font-Size="Small" Text='<%# Bind("fulladd") %>'></asp:Label><br />
                                        <asp:Label ID="lbljo" runat="server" Text='<%# Bind("jo") %>'></asp:Label>
                                    </div>

                                    <asp:LinkButton ID="LinkButton2" runat="server" CommandName="showquotation" CssClass="btn btn-primary"><span class="glyphicon glyphicon-resize-vertical"></span> quotation(s)</asp:LinkButton>
                                    <asp:Panel ID="Panel2" runat="server" ScrollBars="Auto">
                                        <asp:GridView ID="GridView2" Visible="false" AutoGenerateColumns="false" CssClass="table table-striped" GridLines="Both" runat="server">
                                            <Columns>
                                                <asp:TemplateField HeaderText="ase#">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblcin" runat="server" Visible="false" Text='<%# Bind("cin") %>'></asp:Label>
                                                        <asp:Label ID="lblsid" runat="server" Visible="false" Text='<%# Bind("sid") %>'></asp:Label>
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
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <strong>
                                                            <asp:Label ID="Label8" runat="server" CssClass="text-success" Visible='<%# Eval("status").ToString()=="Done" ? true : false %>' Text='<%# Eval("status").ToString() + " Servicing" %>'></asp:Label></strong>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>

                                            <HeaderStyle Wrap="false" />
                                            <RowStyle Wrap="false" />
                                        </asp:GridView>
                                    </asp:Panel>
                                    <table class="table" border="0" style="font-size: small">
                                        <tr>
                                            <td>Bill Amount
                                            </td>
                                            <td class="text-right">
                                                <strong>
                                                    <asp:Label ID="Label4" CssClass="text-info" runat="server" Text='<%# Bind("bill_amount") %>'></asp:Label></strong>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Discounted Price
                                            </td>
                                            <td class="text-right">
                                                <strong>
                                                    <asp:Label ID="Label9" CssClass="text-info" runat="server" Text='<%# Bind("discounted_price") %>'></asp:Label></strong>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Collected Amount
                                            </td>
                                            <td class="text-right">
                                                <strong>
                                                    <asp:Label ID="Label5" CssClass="text-success" runat="server" Text='<%# Bind("payment") %>'></asp:Label></strong>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Balance
                                            </td>
                                            <td class="text-right">
                                                <strong>
                                                    <asp:Label ID="Label6" CssClass="text-danger" runat="server" Text='<%# Bind("balance") %>'></asp:Label></strong>
                                            </td>
                                        </tr>


                                    </table>
                                    <div class="panel-footer">
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle Wrap="False" />

                    <EmptyDataTemplate>
                        <div class="alert alert-danger">
                            <h2><strong>Empty Table!</strong>
                                <small>0 result found</small>
                            </h2>
                        </div>
                    </EmptyDataTemplate>
                    <EditRowStyle BorderStyle="None" BorderWidth="0px" />
                    <PagerSettings PageButtonCount="15" Position="TopAndBottom" />
                    <PagerStyle CssClass="GridPager" HorizontalAlign="Left" />
                </asp:GridView>
                <br />
                <br />
                <div style="padding: 20px; margin: 20px; border-left: 5px solid red; border-radius: 5px; background-color: white; min-width:450px; background-color:aliceblue;">
                    <h3>
                        <span>Bill Amount:</span>
                        <span class="pull-right" style="letter-spacing: 2px; font-weight: bold;">
                            <asp:Label ID="lblbill_amount_summary" runat="server" Text="Label"></asp:Label><br />
                            <asp:Label ID="lbldiscounted_price_summary" runat="server" Text="Label"></asp:Label><br />
                            <asp:Label ID="lblpayment_summary" CssClass="text-success" runat="server" Text="Label"></asp:Label><br />
                            <asp:Label ID="lblbalance_summary" CssClass="text-danger" runat="server" Text="Label"></asp:Label>
                        </span>
                        <br />
                        <span>Discounted Price:</span><br />
                        <span>Collected Amount:</span><br />
                        <span>Balance:</span>
                    </h3>
                </div>
            </asp:Panel>

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
