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
            <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
                <asp:GridView ID="GridView1" CssClass="table" AutoGenerateColumns="False" AllowPaging="True" runat="server" OnRowCommand="GridView1_RowCommand" OnPageIndexChanging="GridView1_PageIndexChanging" BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px" CellPadding="4">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="editbtn" CommandName="myedit" runat="server">Edit</asp:LinkButton>
                                <asp:LinkButton ID="deletebtn" CommandName="mydelete" OnClientClick="return confirm('are you sude you want to delete this record?')" runat="server">Delete</asp:LinkButton>
                                <asp:LinkButton ID="updatebtn" Visible="false" runat="server" CommandName="mysave">Update</asp:LinkButton>
                                <asp:LinkButton ID="cancelbtn" Visible="false" runat="server" CommandName="mycancel">Cancel</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Specification">
                            <ItemTemplate>
                                <asp:Label Visible="false" ID="idlbl" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                <asp:Label ID="specificationlbl" runat="server" Text='<%# Bind("SPECIFICATION") %>'></asp:Label>
                                <asp:TextBox ID="specificationtbox"  Visible="false" placeholder="Specification" runat="server"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description">
                            <ItemTemplate>
                                <asp:Label ID="descriptionlbl" runat="server" Text='<%# Bind("DESCRIPTION") %>'></asp:Label>
                                <asp:TextBox ID="descriptiontbox"  Visible="false" placeholder="Description" runat="server"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Article #">
                            <ItemTemplate>
                                <asp:Label ID="articlelbl" runat="server" Text='<%# Bind("ARTICLENO") %>'></asp:Label>
                                <asp:TextBox ID="articletbox"  Visible="false" placeholder="Article number" runat="server"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Unit">
                            <ItemTemplate>
                                <asp:Label ID="unitlbl" runat="server" Text='<%# Bind("UNIT") %>'></asp:Label>
                                <asp:TextBox ID="unittbox"  Visible="false" placeholder="Unit" runat="server"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Unit price">
                            <ItemTemplate>
                                <asp:Label ID="unitpricelbl" runat="server" Text='<%# Bind("[UNIT PRICE]") %>'></asp:Label>
                                <asp:TextBox ID="unitpricetbox"  Visible="false" placeholder="Unit price" runat="server"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Remarks">
                            <ItemTemplate>
                                <asp:Label ID="remarkslbl" runat="server" Text='<%# Bind("REMARKS") %>'></asp:Label>
                                <asp:TextBox ID="remarkstbox" Visible="false" placeholder="Remarks" runat="server"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
                    <HeaderStyle Wrap="False" BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
                    <PagerStyle CssClass="GridPager" HorizontalAlign="Center" BackColor="#FFFFCC" ForeColor="#330099"/>
                    <RowStyle Wrap="False" BackColor="White" ForeColor="#330099" />
                    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
                    <EmptyDataTemplate>
                        <div class="alert alert-danger">
                            <h2><strong>Sorry, no data available!</strong>
                                <small>0 result found</small>
                            </h2>
                        </div>
                    </EmptyDataTemplate>
                    <SortedAscendingCellStyle BackColor="#FEFCEB" />
                    <SortedAscendingHeaderStyle BackColor="#AF0101" />
                    <SortedDescendingCellStyle BackColor="#F6F0C0" />
                    <SortedDescendingHeaderStyle BackColor="#7E0000" />
                </asp:GridView>
            </asp:Panel>
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
