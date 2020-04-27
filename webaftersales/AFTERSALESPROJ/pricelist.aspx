<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="pricelist.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.pricelist" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Price List</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="well">
        <h3><strong>Price List</strong></h3>
        <div class="input-group">
            <asp:TextBox ID="key" CssClass="form-control" runat="server"></asp:TextBox>
            <div class="input-group-btn">
                <asp:LinkButton ID="LinkButton1" CssClass="btn btn-primary" runat="server" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
            </div>
        </div>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>


            <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />

            <asp:GridView ID="GridView1" GridLines="None" AutoGenerateColumns="False" AllowPaging="True" runat="server" OnRowCommand="GridView1_RowCommand" OnPageIndexChanging="GridView1_PageIndexChanging">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <div class="panel panel-default">

                                <div class="panel-heading">

                                    <asp:LinkButton ID="LinkButton2" CommandName="myedit" runat="server">Edit</asp:LinkButton>

                                </div>
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <asp:Label Visible="false" ID="idlbl" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                            <asp:Label ID="specificationlbl" Font-Size="Large" runat="server" Text='<%# Bind("SPECIFICATION") %>'></asp:Label><br />
                                            <asp:Label ID="descriptionlbl" Font-Size="Medium" runat="server" Text='<%# Bind("DESCRIPTION") %>'></asp:Label><br />
                                            <asp:Label ID="Label1" runat="server" CssClass="text-muted" Text="ARTICLE #: "></asp:Label>
                                            <asp:Label ID="articlelbl" runat="server" Text='<%# Bind("ARTICLENO") %>'></asp:Label>
                                        </div>
                                        <div class="col-sm-6">
                                            <table border="1" class="table">
                                                <tr>
                                                    <th>Unit</th>
                                                    <th>Unit price</th>
                                                    <th>Remarks</th>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="unitlbl" runat="server" Text='<%# Bind("UNIT") %>'></asp:Label></td>
                                                    <td>
                                                        <asp:Label ID="unitpricelbl" runat="server" Text='<%# Bind("[UNIT PRICE]") %>'></asp:Label></td>
                                                    <td>
                                                        <asp:Label ID="remarkslbl" runat="server" Text='<%# Bind("REMARKS") %>'></asp:Label></td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>

                                    <asp:Panel ID="Panel1" Visible="false" runat="server">
                                        <div class="panel panel-default">
                                            <div class="panel-body">
                                                Specification<br />
                                                <asp:TextBox ID="specificationtbox" CssClass="form-control" placeholder="Specification" runat="server"></asp:TextBox><br />
                                                Article number<br />
                                                <asp:TextBox ID="articletbox" CssClass="form-control" placeholder="Article number" runat="server"></asp:TextBox><br />
                                                Description<br />
                                                <asp:TextBox ID="descriptiontbox" CssClass="form-control" placeholder="Description" runat="server"></asp:TextBox><br />
                                                Unit<br />
                                                <asp:TextBox ID="unittbox" CssClass="form-control" placeholder="Unit" runat="server"></asp:TextBox><br />
                                                Unit price<br />
                                                <asp:TextBox ID="unitpricetbox" CssClass="form-control" placeholder="Unit price" runat="server"></asp:TextBox><br />
                                                Remarks<br />
                                                <asp:TextBox ID="remarkstbox" CssClass="form-control" placeholder="Remarks" runat="server"></asp:TextBox><br />
                                                <asp:Button ID="Button2" runat="server" CommandName="mysave" CssClass="btn btn-primary" Text="save" />

                                            </div>

                                            <div class="panel-footer">
                                                <asp:Button ID="Button3" runat="server" CommandName="mycancel" CssClass="btn btn-default" Text="cancel" />
                                                <div class="navbar-right">
                                                    <asp:LinkButton ID="LinkButton3" CommandName="mydelete" OnClientClick="return confirm('are you sude you want to delete this record?')" CssClass="btn btn-default" runat="server"><span class="glyphicon glyphicon-trash"></span></asp:LinkButton>
                                                </div>

                                            </div>
                                        </div>
                                    </asp:Panel>


                                </div>
                            </div>

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
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />

    <div class="panel panel-default">
        <div class="panel-body">
            Specification<br />
            <asp:TextBox ID="specificationtbox" CssClass="form-control" placeholder="Specification" runat="server"></asp:TextBox><br />
            Article number<br />
            <asp:TextBox ID="articletbox" CssClass="form-control" placeholder="Article number" runat="server"></asp:TextBox><br />
            Description<br />
            <asp:TextBox ID="descriptiontbox" CssClass="form-control" placeholder="Description" runat="server"></asp:TextBox><br />
            Unit<br />
            <asp:TextBox ID="unittbox" CssClass="form-control" placeholder="Unit" runat="server"></asp:TextBox><br />
            Unit price<br />
            <asp:TextBox ID="unitpricetbox" CssClass="form-control" placeholder="Unit price" runat="server"></asp:TextBox><br />
            Remarks<br />
            <asp:TextBox ID="remarkstbox" CssClass="form-control" placeholder="Remarks" runat="server"></asp:TextBox><br />
            <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary" Text="save" OnClick="Button1_Click" />
        </div>
    </div>


</asp:Content>
