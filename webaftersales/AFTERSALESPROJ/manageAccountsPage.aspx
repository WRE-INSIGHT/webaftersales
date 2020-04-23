<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="manageAccountsPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.manageAccountsPage" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>


<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">
    <script>
        function confirmation() {
            confirm('delete this record?');
        }
        function alertme() {
            alert("action successfully executed");
        }
        function invalidaccess() {
            alert("invalid access!");
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="well">
        <h3><strong>Manage Accounts</strong></h3>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="val1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="panel panel-default">
                <div class="panel-heading">
                    For verification
                </div>
                <div class="panel-body">
                    <asp:GridView CssClass="table table-hover" GridLines="None" ID="GridView1" runat="server" AutoGenerateColumns="False"
                        OnRowCommand="GridView1_RowCommand" DataKeyNames="ID" OnRowDataBound="GridView1_RowDataBound"
                        PageSize="5" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" EmptyDataText="no data available for this content">
                        <Columns>
                            <asp:TemplateField HeaderText="id">
                                <ItemTemplate>
                                    <asp:Label ID="lblid" runat="server" Text='<%# Eval("ID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="lastname">
                                <ItemTemplate>
                                    <asp:Label ID="lbllastname" runat="server" Text='<%# Bind("LASTNAME") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="firstname">
                                <ItemTemplate>
                                    <asp:Label ID="lblfirstname" runat="server" Text='<%# Bind("FIRSTNAME") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField HeaderText="pid" DataField="pid" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div class="navbar-right">
                                        <asp:LinkButton CssClass="btn btn-success" Width="100" ID="LinkButton2" CommandName="myverification" runat="server"><span class="glyphicon glyphicon-check"></span>&nbsp;verify</asp:LinkButton>
                                        <asp:LinkButton CssClass="btn btn-danger" Width="100" ID="LinkButton1" CommandName="mycancel"
                                            OnClientClick="return confirm('Are you sure you want to delete this record?');" ToolTip="Cancel this account?" runat="server"><span class="glyphicon glyphicon-minus-sign"></span>&nbsp;delete</asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                        <PagerSettings PageButtonCount="8" />
                        <PagerStyle CssClass="GridPager" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="#CCCCFF" Font-Bold="True" />
                    </asp:GridView>
                </div>
                  <div class="panel-footer">
                    Footer
                </div>
            </div>

            <div class="panel panel-primary">
                <div class="panel-heading">
                    Personnel's Table
                </div>
                <div class="panel-body">

                    <div class="input-group">
                        <asp:TextBox ID="tboxfind" CssClass="form-control" runat="server"></asp:TextBox>
                        <div class=" input-group-btn">
                            <asp:LinkButton ID="LinkButton3" CssClass="btn btn-primary" runat="server" OnClick="LinkButton3_Click">Find</asp:LinkButton>
                        </div>
                    </div>
                    <asp:Panel ID="Panel1" Visible="false" CssClass="alert alert-success" runat="server">
                        <h2>
                            <small>all names where </small>
                            <asp:Label ID="lblresultlastname" runat="server" Text="Label"></asp:Label>
                            <small>or</small>
                            <asp:Label ID="lblresultdirstname" runat="server" Text="Label"></asp:Label>
                            <small> word is present in the record.</small>
                        </h2>
                    </asp:Panel>

                    <asp:GridView ID="GridView3" CssClass=" table table-hover" GridLines="None" runat="server"
                        AllowPaging="True" PageSize="5" OnPageIndexChanging="GridView3_PageIndexChanging" AutoGenerateColumns="false" OnRowCommand="GridView3_RowCommand">
                        <Columns>
                            <asp:TemplateField HeaderText="pid">
                                <ItemTemplate>
                                    <asp:Label ID="pidlbl" runat="server" Text='<%# Bind("PID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="fullname">
                                <ItemTemplate>
                                    <asp:Label ID="fullnamelbl" runat="server" Text='<%# Bind("FULLNAME") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="position">
                                <ItemTemplate>
                                    <asp:Label ID="positionlbl" runat="server" Text='<%# Bind("POSITION") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div class="navbar-right">
                                        <asp:LinkButton ID="validatebtn" CommandName="validate" CssClass="btn btn-success" OnClientClick="return confirm('continue validation?');"
                                            Visible='<%# Eval("A").ToString() == "1" ? true : false%>' runat="server"><span class="glyphicon glyphicon-check"></span>&nbsp;validate request</asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerSettings PageButtonCount="8" />
                        <PagerStyle CssClass="GridPager" HorizontalAlign="Center" />
                        <EmptyDataTemplate>
                            <h1><small><strong>0 result found!</strong></small></h1>
                        </EmptyDataTemplate>
                    </asp:GridView>

                </div>
                <div class="panel-footer">
                    Footer
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <div class="panel-group">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <asp:HyperLink ID="HyperLink1" runat="server" data-toggle="collapse" href="#collapse1"><span class="glyphicon glyphicon-resize-vertical"></span>&nbsp;User Accounts</asp:HyperLink>
                </h4>
            </div>
            <div id="collapse1" class="panel-collapse collapse">
                <div class="panel-body">
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <div class="input-group">
                                <asp:TextBox ID="tboxfinduser" CssClass="form-control" runat="server"></asp:TextBox>
                                <div class=" input-group-btn">
                                    <asp:LinkButton ID="LinkButton4" CssClass="btn btn-primary" runat="server" OnClick="LinkButton4_Click">Find</asp:LinkButton>
                                </div>
                            </div>
                            <asp:GridView ID="GridView2" CssClass="table table-stripped" AllowPaging="true" PageSize="10"
                                GridLines="None" runat="server" AutoGenerateColumns="false" OnPageIndexChanging="GridView2_PageIndexChanging" OnRowCommand="GridView2_RowCommand">
                                <Columns>
                                    <asp:TemplateField HeaderText="id">
                                        <ItemTemplate>
                                            <asp:Label ID="lblid" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderText="lastname" DataField="LASTNAME" />
                                    <asp:BoundField HeaderText="firstname" DataField="FIRSTNAME" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <div class="navbar-right">
                                                <asp:LinkButton ID="LinkButton5" CssClass="btn btn-danger" CommandName="mydelete" OnClientClick="return confirm('Are you sure you want to delete this record?');"
                                                    Visible='<%# Eval("ACCTTYPE").ToString() == "Admin" ? false : true %>' runat="server"><span class="glyphicon glyphicon-minus-sign"></span></asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <PagerSettings PageButtonCount="8" />
                                <PagerStyle CssClass="GridPager" HorizontalAlign="Center" />
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="panel-footer">Footer</div>
            </div>
        </div>
    </div>
</asp:Content>
