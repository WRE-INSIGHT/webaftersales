﻿<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="assessmentPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.assessmentPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Cutting list</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>Cutting list</strong></h3>
        <div class="navbar-right">
            <asp:HyperLink ID="HyperLink1" CssClass="btn btn-default" NavigateUrl="~/AFTERSALESPROJ/assessmentmade.aspx" runat="server" Text="back"></asp:HyperLink>
        </div>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="val1" runat="server" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <h4>
                <asp:Label ID="lblkno" runat="server" Text="Label"></asp:Label>&nbsp;
                    <asp:Label ID="lbllocation" runat="server" Text="Label"></asp:Label>&nbsp;cutting list<br />
            </h4>
            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                <ContentTemplate>
                    <div class=" input-group">
                        <asp:TextBox ID="findtbox" CssClass="form-control" runat="server"></asp:TextBox>
                        <div class="input-group-btn">
                            <asp:LinkButton ID="LinkButton3" OnClick="findbtn_Click" CssClass="btn btn-default" runat="server"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                        </div>
                    </div>
                    <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
                        <asp:GridView ID="GridView1" CssClass="table" runat="server"
                            AutoGenerateColumns="False"
                            AllowPaging="True" DataKeyNames="ID"
                            OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="20"
                            OnRowDataBound="GridView1_RowDataBound" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Both">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                        <asp:Label ID="Label6" Visible="false" runat="server" Text='<%# Bind("STOCKNO") %>'></asp:Label>
                                        <asp:CheckBox ID="cboxselect" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Description">
                                    <ItemTemplate>
                                        <asp:Label ID="Label11" runat="server" Text='<%# Bind("DESCRIPTION") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="HEADER">
                                    <ItemTemplate>
                                        <asp:Label ID="Label7" runat="server" Text='<%# Bind("HEADER") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="COSTHEAD">
                                    <ItemTemplate>
                                        <asp:Label ID="Label8" runat="server" Text='<%# Bind("COSTHEAD") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="COLOR">
                                    <ItemTemplate>
                                        <asp:Label ID="Label9" runat="server" Text='<%# Bind("TYPECOLOR") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ARTICLE #">
                                    <ItemTemplate>
                                        <asp:Label ID="Label10" runat="server" Text='<%# Bind("ARTICLENO") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                            <HeaderStyle Wrap="False" BackColor="#333333" Font-Bold="True" ForeColor="White" />
                            <PagerStyle HorizontalAlign="Right" CssClass="GridPager" BackColor="White" ForeColor="Black" />
                            <EmptyDataTemplate>
                                <div class="">
                                    <h2><strong>This table is empty!</strong>
                                        <small>There are no cutting list inputs in the original system.</small>
                                    </h2>
                                </div>
                            </EmptyDataTemplate>
                            <RowStyle Wrap="False" />
                            <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F7F7F7" />
                            <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                            <SortedDescendingCellStyle BackColor="#E5E5E5" />
                            <SortedDescendingHeaderStyle BackColor="#242121" />
                        </asp:GridView>
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>


            <br />
            <asp:LinkButton ID="LinkButton1" CLASS="btn btn-primary" OnClick="importbtn_Click" runat="server">import</asp:LinkButton>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
