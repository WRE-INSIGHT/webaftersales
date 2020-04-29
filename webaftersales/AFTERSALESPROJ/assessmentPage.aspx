<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="assessmentPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.assessmentPage" %>

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

            <div class="panel panel-primary">
                <div class="panel-heading">
                    <asp:Label ID="lblkno" runat="server" Text="Label"></asp:Label>
                    <asp:Label ID="lbllocation" runat="server" Text="Label"></asp:Label>&nbsp;cutting list
                </div>

                <div class="panel-body">
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <div class=" input-group">
                                <asp:TextBox ID="findtbox" CssClass="form-control" runat="server"></asp:TextBox>
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="LinkButton3" OnClick="findbtn_Click" CssClass="btn btn-default" runat="server"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                                </div>
                            </div>
                            <asp:GridView ID="GridView1" GridLines="None" runat="server"
                                AutoGenerateColumns="False"
                                AllowPaging="True" DataKeyNames="ID"
                                OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="5"
                                OnRowDataBound="GridView1_RowDataBound" ShowFooter="True">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                            <asp:Label ID="Label6" Visible="false" runat="server" Text='<%# Bind("STOCKNO") %>'></asp:Label>
                                            <div class="panel panel-success">
                                                <div class="panel-heading">
                                                      <asp:CheckBox ID="cboxselect" CssClass="btn btn-default" runat="server" />  <asp:Label ID="Label11" runat="server" Text='<%# Bind("DESCRIPTION") %>'></asp:Label>
                                                </div>
                                                <div class="panel-body">
                                                    <table class="table" border="1">
                                                       
                           
                                                        <tr>
                                                            <td  class="text-muted"><strong>Header</strong></td>
                                                            <td>
                                                                <asp:Label ID="Label7" runat="server" Text='<%# Bind("HEADER") %>'></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td  class="text-muted"><strong>Costhead</strong></td>
                                                            <td>
                                                                <asp:Label ID="Label8" runat="server" Text='<%# Bind("COSTHEAD") %>'></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td  class="text-muted"><strong>Color</strong></td>
                                                            <td>
                                                                <asp:Label ID="Label9" runat="server" Text='<%# Bind("TYPECOLOR") %>'></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="text-muted"><strong>Article #</strong></td>
                                                            <td>
                                                                <asp:Label ID="Label10" runat="server" Text='<%# Bind("ARTICLENO") %>'></asp:Label>
                                                            </td>
                                                        </tr>
                                                      

                                                    </table>
                                                </div>
                                            </div>

                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                <EmptyDataTemplate>
                                    <div class="alert alert-danger">
                                        <h2><strong>Sorry, no data available!</strong>
                                            <small>0 result found</small>
                                        </h2>
                                    </div>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="panel-footer">Footer</div>
            </div>

            <br />
            <asp:LinkButton ID="LinkButton1" CLASS="btn btn-primary" OnClick="importbtn_Click" runat="server">import</asp:LinkButton>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
