<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="requestquotation.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.requestquotation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Request proposal</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>Request proposal</strong></h3>
        <div class="navbar-right">
            <asp:LinkButton ID="LinkButton2" CssClass="btn btn-default" PostBackUrl="~/AFTERSALESPROJ/reportPage.aspx" runat="server">back</asp:LinkButton>
        </div>

    </div>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
    <strong>
        <asp:Label ID="lblproject" Font-Size="X-Large" runat="server" Text="Project Name"></asp:Label></strong><br />
    <asp:Label ID="lbladdress" Font-Size="Medium" runat="server" Text="Address"></asp:Label><br />
    <asp:Label ID="lbljo" Font-Size="Medium" runat="server" Text="Job Order No."></asp:Label><br />
    <h2>
        <asp:Label ID="lbldate" runat="server" Text="Date"></asp:Label>
        <small>
            <asp:Label ID="lblservicing" runat="server" Text="Servicing"></asp:Label></small></h2>
    <br />

    <div class="panel panel-default">
        <div class="panel-heading">
            <div class="input-group">
                <div class="input-group-addon">
                    search key
                </div>
                <asp:TextBox ID="searchkey" CssClass="form-control" runat="server"></asp:TextBox>

                <div class="input-group-btn">
                    <asp:LinkButton ID="LinkButton1" CssClass="btn btn-success" runat="server" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                </div>
            </div>
        </div>
        <div class="panel-body">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:Panel ID="Panel4" runat="server" ScrollBars="Auto">
                        <asp:GridView ID="GridView2" GridLines="Vertical"  CssClass="table" runat="server" AutoGenerateColumns="False" AllowPaging="True" PageSize="5" OnPageIndexChanging="GridView2_PageIndexChanging" OnRowCommand="GridView2_RowCommand">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton3" CommandName="tryimport" runat="server">import</asp:LinkButton>
                                        <asp:Panel ID="Panel2" Visible="false" runat="server">
                                            Qty<br />
                                            <asp:TextBox ID="tboxqty" runat="server" TextMode="Number"></asp:TextBox><br />
                                            <asp:LinkButton ID="LinkButton4" CommandName="myimport" runat="server">add</asp:LinkButton>&nbsp;&nbsp;
                                             <asp:LinkButton ID="LinkButton5" CommandName="mycancel" runat="server">cancel</asp:LinkButton>
                                        </asp:Panel>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Article No">
                                    <ItemTemplate>
                                        <asp:Label ID="g2lblid" runat="server" Visible="false" Text='<%# Bind("ID") %>'></asp:Label>
                                        <asp:Label ID="g2lblarticleno" runat="server" Text='<%# Bind("ARTICLENO") %>'></asp:Label>
                                        <asp:Label ID="g2lblunitprice" runat="server" Text='<%# Bind("UNITPRICE") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Description">
                                    <ItemTemplate>
                                        <asp:Label ID="g2lbldescription" runat="server" Text='<%# Bind("DESCRIPTION") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <PagerSettings PageButtonCount="8" />
                            <PagerStyle CssClass="GridPager" HorizontalAlign="Left" />
                            <EmptyDataTemplate>
                                <div class="alert alert-danger">
                                    <h2><strong>Empty Table!</strong>
                                        <small>0 result found</small>
                                    </h2>
                                </div>
                            </EmptyDataTemplate>
                            <RowStyle Wrap="False" />
                        </asp:GridView>
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading">
            <h3><span>Manual input</span></h3>
        </div>
        <div class="panel panel-body">
            Articleno<br />
            <asp:TextBox ID="tboxarticleno" CssClass="form-control" runat="server"></asp:TextBox><br />
            Description<br />
            <asp:TextBox ID="tboxdescription" CssClass="form-control" runat="server"></asp:TextBox><br />
            Qty<br />
            <asp:TextBox ID="tboxqty" CssClass="form-control" TextMode="Number" runat="server"></asp:TextBox><br />
            <asp:Button ID="Button1" Width="100" CommandName="myadd" CssClass="btn btn-primary" runat="server" Text="add" OnClick="Button1_Click" />
            <asp:Button ID="Button2" Width="100" CommandName="myreload" CssClass="btn btn-warning" runat="server" Text="reload" OnClick="Button2_Click" />
        </div>
    </div>
    <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>

                <asp:Panel ID="Panel3" runat="server" ScrollBars="Auto">


                    <asp:GridView ID="GridView1" GridLines="Vertical" CssClass="table" runat="server" AutoGenerateColumns="False" AllowPaging="True" OnRowCommand="GridView1_RowCommand" OnPageIndexChanging="GridView1_PageIndexChanging">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnedit" CommandName="myedit" runat="server">Edit</asp:LinkButton>
                                    <asp:LinkButton ID="btndelete" CommandName="mydelete" OnClientClick="return confirm('delete this record?')" runat="server">Delete</asp:LinkButton>
                                    <asp:LinkButton ID="btnupdate" Visible="false" CommandName="myupdate" runat="server">Update</asp:LinkButton>
                                    <asp:LinkButton ID="btncancel" Visible="false" CommandName="mycancel" runat="server">Cancel</asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Article No">
                                <ItemTemplate>
                                    <asp:Label ID="lblid" runat="server" Visible="false" Text='<%# Bind("ID") %>'></asp:Label>
                                    <asp:Label ID="lblarticleno" runat="server" Text='<%# Bind("ARTICLENO") %>'></asp:Label>
                                    <asp:TextBox ID="tboxarticleno" Visible="false" Text='<%# Eval("ARTICLENO") %>' CssClass="form-control" runat="server"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Description">
                                <ItemTemplate>
                                    <asp:Label ID="lbldescription" runat="server" Text='<%# Bind("DESCRIPTION") %>'></asp:Label>
                                    <asp:TextBox ID="tboxdescription" Visible="false" Text='<%# Eval("DESCRIPTION") %>' CssClass="form-control" runat="server"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Qty">
                                <ItemTemplate>
                                    <asp:Label ID="lblqty" runat="server" Text='<%# Bind("QTY") %>'></asp:Label>
                                    <asp:TextBox ID="tboxqty" Visible="false" TextMode="Number" Text='<%# Eval("QTY") %>' CssClass="form-control" runat="server"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                        <PagerSettings PageButtonCount="8" />
                        <PagerStyle CssClass="GridPager" HorizontalAlign="Left" />
                        <EmptyDataTemplate>
                            <div class="alert alert-danger">
                                <h2><strong>Empty Table!</strong>
                                    <small>0 result found</small>
                                </h2>
                            </div>
                        </EmptyDataTemplate>
                        <RowStyle Wrap="False" />
                    </asp:GridView>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </asp:Panel>
</asp:Content>
