﻿<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="importquotationitem.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.importquotationitem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Import Items</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>Import quotation items</strong></h3>
        <div class="navbar-right">
            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-default" PostBackUrl="~/AFTERSALESPROJ/quotationitem.aspx">back</asp:LinkButton>
        </div>
    </div>
    <asp:Label ID="lblaseno" runat="server" Font-Size="X-Large" Text="Label"></asp:Label>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
 
            <asp:Panel ID="Panel1" runat="server" ScrollBars="Horizontal">
                <small>
                    <asp:GridView ID="GridView1" CssClass="table" runat="server" AllowPaging="True" AutoGenerateColumns="False" PageSize="8" 
                        DataKeyNames="ID" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowDataBound="GridView1_RowDataBound" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black">
                        <Columns>
                            <asp:TemplateField HeaderText="K #">
                                <ItemTemplate>
                                    <asp:CheckBox ID="cboxselect" runat="server" />&nbsp;
                                    <asp:Label ID="lblid" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                    <asp:Label ID="lblsid" Visible="false" runat="server" Text='<%# Bind("SID") %>'></asp:Label>
                                    <asp:Label ID="lbljo" Visible="false" runat="server" Text='<%# Bind("JO") %>'></asp:Label>
                                    <asp:Label ID="lblkno" runat="server" Text='<%# Bind("KNO") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Item #">
                                <ItemTemplate>
                                    <asp:Label ID="lblitemno" runat="server" Text='<%# Bind("ITEMNO") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Location">
                                <ItemTemplate>
                                    <asp:Label ID="lbllocation" runat="server" Text='<%# Bind("LOCATION") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Width">
                                <ItemTemplate>
                                    <asp:Label ID="lblwidth" runat="server" Text='<%# Bind("WIDTH") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Height">
                                <ItemTemplate>
                                    <asp:Label ID="lblheight" runat="server" Text='<%# Bind("HEIGHT") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Specification">
                                <ItemTemplate>
                                    <asp:Label ID="lblspecification" runat="server" Text='<%# Bind("SPECIFICATION") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mobilization Cost">
                                <ItemTemplate>
                                    <asp:Label ID="lblmobilizationcost" runat="server" Text='<%# Bind("MOBILIZATIONCOST") %>'></asp:Label>
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
                        <FooterStyle BackColor="#CCCCCC" />
                        <HeaderStyle Wrap="False" BorderStyle="None" BorderWidth="0px" BackColor="Black" Font-Bold="True" ForeColor="White" />
                        <PagerStyle CssClass="GridPager" HorizontalAlign="Left" BackColor="#CCCCCC" ForeColor="Black" />
                        <RowStyle Wrap="False" BackColor="White" />
                        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#808080" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#383838" />
                    </asp:GridView>
                </small>
            </asp:Panel>
            <br />
            <asp:Button ID="Button1" CssClass="btn btn-primary" runat="server" Text="import" OnClick="Button1_Click" />
      
</asp:Content>
