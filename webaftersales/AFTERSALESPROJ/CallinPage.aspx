<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="CallinPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.CallinPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Call-in</title>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <table>
            <tr>
                <td>
                    <h3><strong>Call-in Records</strong></h3>
                </td>
                <td>
                    <asp:LinkButton ID="LinkButton3" runat="server" OnClick="LinkButton3_Click">new</asp:LinkButton></td>
            </tr>
        </table>

        <div class="input-group">
            <asp:TextBox ID="callinkey" CssClass="form-control" runat="server"></asp:TextBox>
            <div class="input-group-btn">
                <asp:LinkButton ID="LinkButton1" CssClass="btn btn-primary" runat="server" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
            </div>
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
                            <div class="row">
                                <div class="col-sm-6">
                                    <asp:Label ID="callinidlbl" runat="server" Visible="false" Text='<%# Eval("AUTONUM") %>'></asp:Label>


                                    <strong>
                                        <asp:Label ID="projectlbl" Font-Size="Large" runat="server" Text='<%# Bind("PROJECT") %>'></asp:Label></strong>
                                    <br />
                                    <asp:Label ID="addresslbl" Font-Size="Medium" runat="server" Text='<%# Bind("ADDRESS") %>'></asp:Label>
                                    <br />
                                    <table border="0" class="table">
                                        <tr>
                                            <th>JO
                                            </th>
                                            <th>JO DATE
                                              
                                            </th>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="jolbl" runat="server" Text='<%# Eval("JO") %>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="Label10" runat="server" Text='<%# Bind("JODATE") %>'></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                    <asp:Label ID="datelbl" Font-Size="XX-Large" runat="server" Text='<%# Bind("DATE") %>'></asp:Label>
                                    <br />
                                </div>
                                <div class="col-sm-6">
                                    <div class="panel panel-default">
                                        <table class="table">
                                            <tr>
                                                <th>EIC</th>
                                                <th>AEIC</th>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("EIC") %>'></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("AEIC") %>'></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <table border="1" class="table">

                                                        <tr>
                                                            <td class="text-muted"><small>Status</small> </td>
                                                            <td>
                                                                <asp:Label ID="statuslbl" Font-Size="Medium" runat="server" Text='<%# Bind("STATUS") %>'></asp:Label></td>

                                                        </tr>
                                                        <tr>
                                                            <td class="text-muted"><small>Concern</small></td>

                                                            <td>
                                                                <asp:Label ID="concernlbl" runat="server" Text='<%# Eval("CONCERN") %>'></asp:Label>
                                                            </td>

                                                        </tr>
                                                        <tr>
                                                            <td class="text-muted"><small>Conversation</small> </td>
                                                            <td>
                                                                <asp:Label ID="conversationlbl" runat="server" Text='<%# Eval("CONVERSATION") %>'></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="text-muted"><small>Color</small> </td>
                                                            <td>
                                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("[PROFILE FINISH]") %>'></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <table>
                                                        <tr>
                                                            <td class="text-muted">Contact person</td>
                                                            <td>
                                                                <asp:Label ID="contactpersonlbl" runat="server" Text='<%# Eval("CONTACTPERSON") %>'></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="text-muted">Tel #</td>
                                                            <td>
                                                                <asp:Label ID="telnolbl" runat="server" Text='<%# Eval("TELNO") %>'></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="text-muted">Fax #</td>
                                                            <td>
                                                                <asp:Label ID="faxnolbl" runat="server" Text='<%# Eval("FAXNO") %>'></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <asp:LinkButton ID="LinkButton4" CommandName="myservicing" CssClass="btn btn-primary" runat="server">manage job order</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                        <div class="panel-footer">
                            <asp:Label ID="Label4" CssClass="text-muted" runat="server" Text="caller "></asp:Label>
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
