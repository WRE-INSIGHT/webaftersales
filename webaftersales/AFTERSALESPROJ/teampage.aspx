<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="teampage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.teampage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Teams</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="page-header">
        <h3><strong>Team Management</strong></h3>
        <div class="navbar-right">
            <asp:Button ID="Button1" CssClass="btn btn-default" runat="server" Text="back" />
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-sm-4">

            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>




                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            Human resources
                        </div>
                        <div class="panel-body">
                            <div class="input-group">
                                <asp:TextBox ID="keytbox" CssClass="form-control" runat="server"></asp:TextBox>
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" runat="server" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                                </div>
                            </div>
                            <asp:GridView ID="GridView1" GridLines="None" AutoGenerateColumns="false" AllowPaging="true" runat="server" OnRowCommand="GridView1_RowCommand" PageSize="20" OnPageIndexChanging="GridView1_PageIndexChanging">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <table>
                                                <tr>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="fullnamelbl" runat="server" Font-Size="Large" Text='<%# Bind("FULLNAME") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <h4><small>
                                                            <asp:Label ID="positionlbl" runat="server" Text='<%# Bind("POSITION") %>'></asp:Label></small></h4>
                                                    </td>
                                                    <td>
                                                        <asp:LinkButton ID="LinkButton2" CommandName="myedit" runat="server">Edit</asp:LinkButton>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3">
                                                        <asp:Panel ID="Panel1" runat="server" Visible="false">
                                                            <div class="panel panel-default">
                                                                <div class="panel-heading">
                                                                    <strong>Edit mode</strong><br />
                                                                </div>
                                                                <div class="panel-body">
                                                                    Fullname<br />
                                                                    <asp:TextBox ID="fullnametbox" placeholder="Fullname" CssClass="form-control" runat="server"></asp:TextBox><br />
                                                                    Position<br />
                                                                    <asp:TextBox ID="positiondl" placeholder="Position" CssClass="form-control" runat="server"></asp:TextBox><br />
                                                                    <asp:Button ID="Button2" CommandName="savebtn" runat="server" CssClass="btn btn-primary" Text="save" />

                                                                </div>
                                                                <div class="panel-footer">
                                                                    <asp:Button ID="Button3" CommandName="cancelbtn" CssClass="btn btn-default" runat="server" Text="Close" />
                                                                    <div class="navbar-right">
                                                                        <asp:LinkButton ID="LinkButton3" OnClientClick="return confirm('Are you sure you want to delete this record?');" CommandName="mydelete" CssClass="btn btn-default" runat="server"><span class="glyphicon glyphicon-trash"></span></asp:LinkButton>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                            </table>
                                            <asp:Label ID="pidlbl" Visible="false" runat="server" Text='<%# Bind("PID") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>

                                <PagerStyle CssClass="GridPager" HorizontalAlign="Left" />
                                <SelectedRowStyle BackColor="#CCFFFF" />
                                <EmptyDataTemplate>
                                    <div class="alert alert-danger">
                                        <h2><strong>Sorry, no data available!</strong>
                                            <small>0 result found</small>
                                        </h2>
                                    </div>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </div>
                        <div class="panel-footer">
                            Footer
                        </div>
                    </div>
                    <div class="panel">
                        <div class="container">
                            Fullname<br />
                            <asp:TextBox ID="newfullnametbox" CssClass="form-control" placeholder="Fullname" runat="server"></asp:TextBox><br />
                            Position<br />
                            <asp:TextBox ID="newpositiontbox" CssClass="form-control" placeholder="Fullname" runat="server"></asp:TextBox><br />
                            <asp:Button ID="Button6" runat="server" CssClass="btn btn-primary" Text="add" OnClick="Button6_Click" />
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>

        </div>

        <div class="col-sm-8">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            Teams
                        </div>
                        <div class="panel-body">
                            <div class="input-group">
                                <asp:TextBox ID="teamkey" CssClass="form-control" runat="server"></asp:TextBox>
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="LinkButton4" CssClass="btn btn-default" runat="server" OnClick="LinkButton4_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                                </div>
                            </div>
                            <asp:GridView ID="GridView2" GridLines="None" runat="server" AutoGenerateColumns="false" AllowPaging="True" PageSize="8"
                                OnRowCommand="GridView2_RowCommand" OnPageIndexChanging="GridView2_PageIndexChanging" OnRowDataBound="GridView2_RowDataBound">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="teamnamelbl" Font-Size="Large" runat="server" Text='<%# Bind("TEAMNAME") %>'></asp:Label>
                                            <asp:LinkButton ID="LinkButton5" CommandName="myedit" runat="server">Edit</asp:LinkButton>
                                            <div class="navbar-right">
                                                <asp:LinkButton ID="assignbtn" CommandName="myedit" runat="server">Assign</asp:LinkButton>
                                            </div>
                                            <br />
                                            <table border="0" class="table">
                                                <tr>
                                                    <td style="width: 80px;">
                                                        <h4><small>Members:</small></h4>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="memberlbl" runat="server" Text='<%# Bind("MEMBERS") %>'></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                            <asp:Panel ID="Panel2" Visible="false" runat="server">
                                                <div class="panel panel-default">
                                                    <div class="panel-heading">
                                                        <strong>Edit mode</strong>
                                                    </div>
                                                    <div class="panel-body">
                                                        <div class="container">
                                                            Team name<br />
                                                            <div class="input-group">
                                                                <asp:TextBox ID="teamnametbox" CssClass="form-control" runat="server"></asp:TextBox>
                                                                <div class="input-group-btn">
                                                                    <asp:Button ID="Button4" CommandName="changename" CssClass="btn btn-default" runat="server" Text="change name" />
                                                                </div>
                                                            </div>

                                                            Member<br />
                                                            <div class="input-group">
                                                                <asp:DropDownList ID="memberdl" Height="35" CssClass="form-control" runat="server"></asp:DropDownList>
                                                                <div class="input-group-btn">
                                                                    <asp:LinkButton ID="LinkButton7" Height="35" CommandName="myadd" CssClass="btn btn-default" runat="server"><span class="glyphicon glyphicon-plus"></span></asp:LinkButton>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <br />

                                                        <asp:GridView ID="GridView3" CssClass="table" GridLines="None" AutoGenerateColumns="false" runat="server"
                                                            OnRowCommand="GridView3_RowCommand">
                                                            <Columns>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="memberidlbl" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                                                        <asp:Label ID="fullnamelbl" runat="server" Text='<%# Bind("FULLNAME") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="LinkButton6" runat="server" CommandName="myremove" CssClass="btn btn-default">remove</asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>

                                                            </Columns>
                                                        </asp:GridView>
                                                    </div>
                                                    <div class="panel-footer">
                                                        <asp:Button ID="Button5" CommandName="myclose" CssClass="btn btn-default" runat="server" Text="Close" />
                                                    </div>
                                                </div>
                                            </asp:Panel>
                                            <asp:Label ID="tidlbl" Visible="false" runat="server" Text='<%# Bind("TID") %>'>></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <PagerStyle CssClass="GridPager" HorizontalAlign="Left" />
                                <SelectedRowStyle BackColor="#CCFFFF" />
                                <EmptyDataTemplate>
                                    <div class="alert alert-danger">
                                        <h2><strong>Sorry, no data available!</strong>
                                            <small>0 result found</small>
                                        </h2>
                                    </div>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </div>
                        <div class="panel-footer">
                            Footer
                        </div>
                    </div>
                    <div class="panel">
                        <div class="container">
                            Team name:<br />
                            <asp:TextBox ID="newteamnametbox" CssClass="form-control" runat="server"></asp:TextBox>
                            <br />
                            <asp:Button ID="Button7" runat="server" CssClass="btn btn-primary" Text="add" OnClick="Button7_Click" />
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="errorrgroup" CssClass="alert alert-danger" runat="server" />
</asp:Content>
