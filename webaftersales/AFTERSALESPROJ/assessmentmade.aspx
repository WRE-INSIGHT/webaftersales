<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="assessmentmade.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.assessmentmade" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Assessment</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>Assessment</strong></h3>
        <div class="navbar-right">
            <asp:HyperLink ID="HyperLink1" CssClass="btn btn-default" NavigateUrl="~/AFTERSALESPROJ/reportPage.aspx" runat="server" Text="back"></asp:HyperLink>
        </div>
    </div>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
    <div class="panel panel-primary">
        <div class="panel-heading">
            <asp:Label ID="lblkno" runat="server" Text="Label"></asp:Label>
            <asp:Label ID="lbllocation" runat="server" Text="Label"></asp:Label>&nbsp;assessment
        </div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="panel-body">
                    <asp:GridView ID="GridView1" GridLines="None" AutoGenerateColumns="false" AllowPaging="true" runat="server" PageSize="5" OnRowCommand="GridView1_RowCommand" OnPageIndexChanging="GridView1_PageIndexChanging">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Label ID="idlbl" runat="server" Visible="false" Text='<%# Bind("ID") %>'></asp:Label>
                                    <asp:Label ID="Label2" runat="server" Visible="false" Text='<%# Bind("REPORTID") %>'></asp:Label>
                                    <div class="panel panel-primary">
                                        <div class="panel-body">

                                            <table border="0" class="table">
                                                <tr>
                                                    <th>Description</th>
                                                    <th>Assessment</th>
                                                    <th>
                                                        <asp:LinkButton ID="LinkButton1" CommandName="myedit" runat="server">Edit</asp:LinkButton></th>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="descriptionlbl" runat="server" Text='<%# Bind("DESCRIPTION") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="assessmentlbl" runat="server" Text='<%# Bind("ASSESSMENT") %>'></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                            <asp:Panel ID="Panel1" Visible="false" runat="server">
                                                <div class="panel panel-default">
                                                    <div class="panel-body">
                                                        Description<br />
                                                        <asp:TextBox ID="descriptiontbox" CssClass="form-control" runat="server"></asp:TextBox><br />
                                                        Assessment<br />
                                                        <asp:TextBox ID="assessmenttbox" TextMode="MultiLine" Rows="10" CssClass="form-control" runat="server"></asp:TextBox><br />
                                                        <asp:Button ID="Button2" CommandName="mysave" CssClass="btn btn-primary" runat="server" Text="save" />
                                                    </div>
                                                    <div class="panel-footer">
                                                        <asp:Button ID="Button1" CommandName="mycancel" CssClass="btn btn-default" runat="server" Text="cancel" />
                                                        <div class="navbar-right">
                                                            <asp:LinkButton ID="LinkButton2" CommandName="mydelete" OnClientClick="return confirm('delete this record?')" CssClass="btn btn-default" runat="server"><span class="glyphicon glyphicon-trash"></span></asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </div>
                                            </asp:Panel>
                                        </div>
                                    </div>



                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerSettings PageButtonCount="8" />
                        <PagerStyle CssClass="GridPager" HorizontalAlign="Center" />
                        <EmptyDataTemplate>
                            <div class="alert alert-danger">
                                <h2><strong>Sorry, no data available!</strong>
                                    <small>0 result found</small>
                                </h2>
                            </div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div class="well">
        <h3>New record</h3>
        Description<br />
        <asp:TextBox ID="newdescriptiontbox" CssClass="form-control" runat="server"></asp:TextBox><br />
        Assessment<br />
        <asp:TextBox ID="newassessmenttbox" TextMode="MultiLine" Rows="10" CssClass="form-control" runat="server"></asp:TextBox><br />
        <asp:Button ID="newbtn" CssClass="btn btn-primary" runat="server" Text="add" OnClick="newbtn_Click" />
    </div>
</asp:Content>
