<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="CallinPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.CallinPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Call-in</title>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-header">
        <h3><strong>Call-in</strong></h3>
        <div class="navbar-right">
            <asp:LinkButton ID="LinkButton3" runat="server" CssClass="btn btn-default" OnClick="LinkButton3_Click">new</asp:LinkButton>
        </div>
    </div>

    <br />
    <div class="input-group">
        <asp:TextBox ID="callinkey" CssClass="form-control" runat="server"></asp:TextBox>
        <div class="input-group-btn">
            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-primary" runat="server" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
        </div>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="val1" runat="server" />
    <asp:GridView ID="GridView1" GridLines="None" runat="server" AllowPaging="True" AutoGenerateColumns="False" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <div class="panel panel-success">
                        <div class="panel-heading">
                            <asp:LinkButton ID="LinkButton2" CommandName="myedit" Font-Size="Medium" runat="server">Edit</asp:LinkButton>
                            <div class="navbar-right">
                                <asp:Label ID="callinlbl" Font-Size="Medium" runat="server" Text='<%# Bind("CIN") %>'></asp:Label>
                            </div>
                        </div>
                        <div class="panel-body">
                            <asp:Label ID="callinidlbl" runat="server" Visible="false" Text='<%# Eval("AUTONUM") %>'></asp:Label>
                            <asp:Label ID="telnolbl" runat="server" Visible="false" Text='<%# Eval("TELNO") %>'></asp:Label>
                            <asp:Label ID="faxnolbl" runat="server" Visible="false" Text='<%# Eval("FAXNO") %>'></asp:Label>


                           <asp:Label ID="jolbl" runat="server" Visible="false" Text='<%# Eval("JO") %>'></asp:Label>
                             <strong><asp:Label ID="projectlbl" Font-Size="Large" runat="server" Text='<%# Bind("PROJECT") %>'></asp:Label></strong>
                            <br />
                            <asp:Label ID="addresslbl" Font-Size="Medium" runat="server" Text='<%# Bind("ADDRESS") %>'></asp:Label>
                            <br />
                            <asp:Label ID="datelbl"  Font-Size="X-Large" runat="server" Text='<%# Bind("DATE") %>'></asp:Label>
                            <br />

                            <div class="panel">
                                <table border="1" class="table">
                                    <tr>
                                        <td>Status</td>
                                        <td>Concern</td>
                                        <td>Conversation</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="statuslbl" Font-Size="Medium" runat="server" Text='<%# Bind("STATUS") %>'></asp:Label></td>
                                        <td>
                                            <asp:Label ID="concernlbl" runat="server" Text='<%# Eval("CONCERN") %>'></asp:Label></td>
                                        <td>
                                            <asp:Label ID="conversationlbl" runat="server" Text='<%# Eval("CONVERSATION") %>'></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <asp:LinkButton ID="LinkButton4" CommandName="myservicing" CssClass="btn btn-default" runat="server">manage servicing schedule</asp:LinkButton>
                        </div>
                        <div class="panel-footer">
                            <asp:Label ID="callerlbl" Font-Size="15px" runat="server" Text='<%# Bind("CALLER") %>'></asp:Label>
                        </div>
                    </div>
                </ItemTemplate>

            </asp:TemplateField>
        </Columns>
         <EmptyDataTemplate>
                    <div class="alert alert-danger">
                        <h2><strong>Sorry, no data available!</strong>
                            <small>0 result found</small>
                        </h2>
                    </div>
                </EmptyDataTemplate>
        <PagerSettings PageButtonCount="8" />
        <PagerStyle CssClass="GridPager" HorizontalAlign="Left" />
    </asp:GridView>
</asp:Content>
