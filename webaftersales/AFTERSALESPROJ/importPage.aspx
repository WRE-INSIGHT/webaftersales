<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="importPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.importPage" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Import</title>
    <script>
        function confimmessage() {
            confirm('import selected items?');
        }
        function alerme() {
            alert("data saved successfully");
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="well">
        <h3><strong>Import k#</strong></h3>
        <div class="navbar-right">
            <asp:HyperLink ID="HyperLink1" CssClass="btn btn-default" NavigateUrl="~/AFTERSALESPROJ/reportPage.aspx" runat="server" Text="back"></asp:HyperLink>
        </div>
    </div>

    <br />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="panel panel-primary">
                <div class="panel-heading">
                    KMDI Sytem data
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="input-group">
                                <div class="input-group-addon">
                                    Location selector
                                </div>
                                <asp:DropDownList ID="locationdl" Height="30" CssClass="form-control" runat="server" AutoPostBack="True" OnSelectedIndexChanged="locationdl_SelectedIndexChanged"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="input-group">
                                <asp:TextBox ID="tboxsearch" Height="30" runat="server" CssClass="form-control"></asp:TextBox>
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" Height="30" runat="server" OnClick="searchbtn_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <br />
                <asp:GridView ID="GridView1" GridLines="None" runat="server"
                    AutoGenerateColumns="False" EmptyDataText="No result found."
                    AllowPaging="True" DataKeyNames="ID"
                    OnPageIndexChanging="GridView1_PageIndexChanging"
                    OnRowDataBound="GridView1_RowDataBound">
                    <Columns>

                        <asp:TemplateField>
                            <ItemTemplate>
                                <div class="panel panel-success">
                                    <div class="panel-heading">
                                        <asp:CheckBox CssClass="btn btn-default" Visible="true" ID="cboxselect" runat="server" />
                                        <asp:Label ID="Label1" Font-Size="Large" runat="server" Text='<%# Bind("LOCATION") %>'></asp:Label>
                                    </div>
                                    <div class="panel-body">
                                        <asp:Label ID="Label6" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                        <table border="1" class="table">
                                            <tr>
                                                <th>K#</th>
                                                <th>Item#</th>
                                                <th>JO</th>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("KMDI_NO") %>'></asp:Label></td>
                                                <td>
                                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("ITEM_NO") %>'></asp:Label></td>
                                                <td>
                                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("job_order_no") %>'></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Dimension</td>
                                                <td colspan="2">
                                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("WIDTH") %>'></asp:Label>&nbsp;x&nbsp;<asp:Label ID="Label7" runat="server" Text='<%# Bind("HEIGHT") %>'></asp:Label></td>

                                            </tr>
                                        </table>
                                    </div>

                                </div>

                            </ItemTemplate>
                        </asp:TemplateField>

                        <%--   <asp:BoundField HeaderText="K#" DataField="KMDI_NO" />
                            <asp:BoundField HeaderText="ITEM#" DataField="ITEM_NO" />
                            <asp:BoundField HeaderText="LOCATION" DataField="LOCATION" />
                            <asp:BoundField HeaderText="JO" DataField="job_order_no" />--%>
                    </Columns>
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
            </div>
                <div class="panel-footer">
                </div>
            </div>

            <asp:Button ID="btnimport" CssClass="btn btn-primary" runat="server" OnClick="btnimport_Click" Text="import" />

            <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="val1" runat="server" />


        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
