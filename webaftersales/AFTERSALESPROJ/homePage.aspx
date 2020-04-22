<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="homePage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.homePage" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Home</title>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <div class="page-header">
        <h3><strong>Kenneth and Mock</strong><small> WINDOWS AND DOORS</small></h3>
    </div>

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container">

        <div class="input-group">
            <asp:TextBox ID="searchtbox" CssClass="form-control" placeholder="project name" runat="server" OnTextChanged="searchtbox_TextChanged"></asp:TextBox>
            <div class="input-group-btn">
                <asp:LinkButton ID="searcbtn2"  CssClass="btn btn-primary" runat="server" OnClick="searcbtn_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
            </div>
        </div>
        <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="val1" CssClass="alert alert-danger" runat="server" />

    </div>
    <br />
    <div class="container">
        <div>
            <h4><small>SERVICING SCHEDULE</small></h4>
        </div>
        <asp:GridView ID="GridView1" GridLines="None" runat="server" AutoGenerateColumns="False" AllowPaging="True"
            OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand" ShowHeader="False"
            HorizontalAlign="Left">
            <Columns>
                <asp:TemplateField HeaderText="">
                    <ItemTemplate>
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <asp:Label ID="Label1" Font-Size="15px" runat="server" Text='<%# Bind("SERVICING") %>'></asp:Label>
                                <asp:Label ID="cidlbl" CssClass="navbar-right" Font-Size="13px" runat="server" Text='<%# Bind("CIN") %>'></asp:Label>
                            </div>
                            <div class="panel-body">
                                <asp:Label ID="idlbl" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                <asp:Label ID="jolbl" Visible="false" runat="server" Text='<%# Bind("JO") %>'></asp:Label>
                                <asp:Label ID="teamlbl" Visible="false" runat="server" Text='<%# Bind("TEAMID") %>'></asp:Label>
                                <strong>
                                    <asp:LinkButton ID="projectlbl" Font-Size="20px" CommandName="report" runat="server" Text='<%# Bind("PROJECT") %>'></asp:LinkButton></strong>
                                <br />
                                <asp:Label ID="addresslbl" Font-Size="15px" runat="server" Text='<%# Bind("ADDRESS") %>'></asp:Label>
                                <br />
                                <asp:Label ID="datelbl" Font-Size="20px" runat="server" Text='<%# Bind("DATE") %>'></asp:Label>
                                <asp:Label ID="colorlbl" Visible="false" runat="server" Text='<%# Bind("PROFILE_FINISH") %>'></asp:Label>
                            </div>
                            <div class="panel-footer">
                                <asp:Label ID="Label2" Font-Size="13px" runat="server" Text='<%# Bind("CALLER") %>'></asp:Label>


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
            <EditRowStyle BorderStyle="None" BorderWidth="0px" />
            <PagerSettings PageButtonCount="8" />
            <PagerStyle CssClass="GridPager" HorizontalAlign="Left" />
            <%--   <RowStyle Font-Names="Segoe UI" Font-Size="10pt" Height="120px" CssClass="rowstyle" />--%>
        </asp:GridView>
    </div>


</asp:Content>
