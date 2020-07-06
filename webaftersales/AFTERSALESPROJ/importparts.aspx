<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="importparts.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.importparts" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Parts import</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>Parts import</strong></h3>
        <div class="navbar-right">
            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-default" PostBackUrl="~/AFTERSALESPROJ/quotationitem.aspx">back</asp:LinkButton>
        </div>
    </div>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
    <br />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
        <ContentTemplate>
            <asp:GridView ID="GridView3" CssClass="table" runat="server" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1" >
                <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />
                <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
                <RowStyle BackColor="#DEDFDE" ForeColor="Black" />
                <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#594B9C" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#33276A" />
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:Label ID="Label7" Font-Size="X-Large" runat="server" Text="Price List"></asp:Label>
    <div class="input-group">
        <asp:TextBox ID="searchtbox" CssClass="form-control" runat="server"></asp:TextBox>
        <div class="input-group-btn">
            <asp:LinkButton ID="LinkButton2" CssClass="btn btn-default" runat="server" OnClick="LinkButton2_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
        </div>
    </div>
    <br />
    <asp:Panel ID="Panel2" runat="server" ScrollBars="Horizontal">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridView2" CssClass="table" runat="server" AllowPaging="True" AutoGenerateColumns="False" PageSize="5" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black" OnRowCommand="GridView2_RowCommand" OnPageIndexChanging="GridView2_PageIndexChanging">
                    <Columns>

                        <asp:TemplateField HeaderText="SPECIFICATION">
                            <ItemTemplate>
                                <asp:Label ID="lblid" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                <asp:LinkButton ID="LinkButton3" CommandName="myimport" runat="server">import</asp:LinkButton>&nbsp;
                                        <asp:Label ID="lblspecification" runat="server" Text='<%# Bind("SPECIFICATION") %>'></asp:Label>
                                <br />
                                <asp:Panel ID="Panel3" Visible="false" runat="server">
                                    Qty<asp:RequiredFieldValidator ControlToValidate="importqtytbox" ValidationGroup="importval" ID="RequiredFieldValidator1" runat="server" ErrorMessage="qty is required" ForeColor="Red">*</asp:RequiredFieldValidator><br />
                                    <asp:TextBox ID="importqtytbox" TextMode="Number" runat="server">1</asp:TextBox><br />
                                    %Markup<asp:RequiredFieldValidator ControlToValidate="importmarkuptbox" ValidationGroup="importval" ID="RequiredFieldValidator2" runat="server" ErrorMessage="markup is required" ForeColor="Red">*</asp:RequiredFieldValidator><br />
                                    <asp:TextBox ID="importmarkuptbox" TextMode="Number" runat="server">30</asp:TextBox>&nbsp;
                                            <asp:LinkButton ID="LinkButton4" CommandName="myadd" ValidationGroup="importval" runat="server">add</asp:LinkButton>&nbsp;
                                            <asp:LinkButton ID="LinkButton5" CommandName="mycancel" runat="server">cancel</asp:LinkButton><br />
                                    <asp:ValidationSummary ValidationGroup="importval" ID="ValidationSummary3" CssClass="alert alert-danger" runat="server" />
                                </asp:Panel>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ARTICLE #">
                            <ItemTemplate>
                                <asp:Label ID="lblarticleno" runat="server" Text='<%# Bind("[ARTICLE NO]") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="DESCRIPTION">
                            <ItemTemplate>
                                <asp:Label ID="lbldescription" runat="server" Text='<%# Bind("[DESCRIPTION]") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="UNIT">
                            <ItemTemplate>
                                <asp:Label ID="lblunit" runat="server" Text='<%# Bind("[UNIT]") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="UNIT PRICE">
                            <ItemTemplate>
                                <asp:Label ID="lblunitprice" runat="server" Text='<%# Bind("[UNIT PRICE]") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="REMARKS">
                            <ItemTemplate>
                                <asp:Label ID="lblremarks" runat="server" Text='<%# Bind("[REMARKS]") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" />
                    <HeaderStyle Wrap="False" BackColor="Black" Font-Bold="True" ForeColor="White" />
                    <PagerSettings PageButtonCount="8" />
                    <PagerStyle CssClass="GridPager" HorizontalAlign="Left" ForeColor="Black" />
                    <EmptyDataTemplate>
                        <div class="alert alert-danger">
                            <h2><strong>Empty Table!</strong>
                                <small>0 result found</small>
                            </h2>
                        </div>
                    </EmptyDataTemplate>
                    <RowStyle Wrap="False" BackColor="White" />
                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#808080" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#383838" />
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
    </asp:Panel>
    <br />
    <asp:Label ID="Label5" runat="server" Font-Size="X-Large" Text="Saved data"></asp:Label>

    <asp:Panel ID="Panel1" runat="server" ScrollBars="Horizontal">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridView1" CssClass="table" AutoGenerateColumns="False" AllowPaging="True" runat="server" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton6" runat="server" CommandName="myedit">Edit</asp:LinkButton>
                                <asp:LinkButton ID="LinkButton9" runat="server" CommandName="mydelete" OnClientClick="return confirm('delete this row?')">Delete</asp:LinkButton>
                                <asp:LinkButton ID="LinkButton7" Visible="false" CommandName="myupdate" ValidationGroup="editval" runat="server">Update</asp:LinkButton>
                                <asp:LinkButton ID="LinkButton8" Visible="false" CommandName="mycancel" runat="server">Cancel</asp:LinkButton>
                            </ItemTemplate>

                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Article #">
                            <ItemTemplate>
                                <asp:Label ID="id" Visible="false" runat="server" Text='<%# Bind("id") %>'></asp:Label>
                                <asp:Label ID="Label2" Visible="false" runat="server" Text='<%# Bind("iid") %>'></asp:Label>
                                <asp:Label ID="articleno" runat="server" Text='<%# Bind("articleno") %>'></asp:Label>
                                <asp:TextBox ID="articlenotboxedit" Visible="false" Text='<%# Eval("articleno") %>' runat="server"></asp:TextBox>
                            </ItemTemplate>

                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description">
                            <ItemTemplate>
                                <asp:Label ID="description" runat="server" Text='<%# Bind("description") %>'></asp:Label>
                                <asp:TextBox ID="descriptiontboxedit" Visible="false" Text='<%# Eval("description") %>' runat="server"></asp:TextBox>
                            </ItemTemplate>

                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="%Markup">
                            <ItemTemplate>
                                <asp:Label ID="markup" runat="server" Text='<%# Bind("markup") %>'></asp:Label>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ForeColor="Red" ControlToValidate="markuptboxedit" ValidationGroup="editval" runat="server" ErrorMessage="">*</asp:RequiredFieldValidator>
                                <asp:TextBox ID="markuptboxedit" Visible="false" OnTextChanged="edittboxunitprice_TextChanged" Width="90" AutoPostBack="true" TextMode="Number" Text='<%# Eval("markup") %>' runat="server"></asp:TextBox>

                            </ItemTemplate>

                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Unit price">
                            <ItemTemplate>
                                <asp:Label ID="unitprice" runat="server" Text='<%# Bind("unitprice") %>'></asp:Label>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ForeColor="Red" ControlToValidate="unitpricetboxedit" ValidationGroup="editval" runat="server" ErrorMessage="">*</asp:RequiredFieldValidator>
                                <asp:TextBox ID="unitpricetboxedit" Visible="false" OnTextChanged="edittboxunitprice_TextChanged" Width="90" AutoPostBack="true" TextMode="Number" Text='<%# Eval("unitprice") %>' runat="server"></asp:TextBox>

                            </ItemTemplate>

                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Qty">
                            <ItemTemplate>
                                <asp:Label ID="qty" runat="server" Text='<%# Bind("qty") %>'></asp:Label>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ForeColor="Red" ControlToValidate="qtytboxedit" ValidationGroup="editval" runat="server" ErrorMessage="">*</asp:RequiredFieldValidator>
                                <asp:TextBox ID="qtytboxedit" Visible="false" OnTextChanged="edittboxunitprice_TextChanged" Width="90" AutoPostBack="true" TextMode="Number" Text='<%# Eval("qty") %>' runat="server"></asp:TextBox>

                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Net price">
                            <ItemTemplate>
                                <asp:Label ID="netamount" runat="server" Text='<%# Bind("netamount") %>'></asp:Label>
                                <asp:TextBox ID="netamounttboxedit" Visible="false" Enabled="false" Text='<%# Eval("netamount") %>' Width="90" runat="server"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="White" ForeColor="#000066" />
                    <HeaderStyle Wrap="False" BackColor="#006699" Font-Bold="True" ForeColor="White" />
                    <PagerSettings PageButtonCount="8" />
                    <PagerStyle CssClass="GridPager" HorizontalAlign="Left" ForeColor="#000066" BackColor="White" />
                    <EmptyDataTemplate>
                        <div class="alert alert-danger">
                            <h2><strong>Empty Table!</strong>
                                <small>0 result found</small>
                            </h2>
                        </div>
                    </EmptyDataTemplate>
                    <RowStyle Wrap="False" ForeColor="#000066" />
                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#007DBB" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#00547E" />
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
    </asp:Panel>
    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
        <ContentTemplate>
            <div class="panel panel-default">
                <div class="panel-body">
                       <asp:Label ID="Label4" Font-Size="X-Large" runat="server" Text="manual input"></asp:Label>
                    <div class="row">
                        <div class="col-sm-6">
                         
                            Article No<br />
                            <asp:TextBox ID="tboxarticle" CssClass="form-control" runat="server"></asp:TextBox><br />
                            Description<br />
                            <asp:TextBox ID="tboxdescription" CssClass="form-control" runat="server"></asp:TextBox><br />
                        </div>
                        <div class="col-sm-6">
                            <table class="table" border="0">
                                <tr>
                                    <td>%Markup<br />
                                        <asp:TextBox ID="tboxmarkup" TextMode="Number" CssClass="form-control" runat="server" AutoPostBack="True" OnTextChanged="tboxunitprice_TextChanged">30</asp:TextBox><br />
                                    </td>
                                    <td>Unit price<br />
                                        <asp:TextBox ID="tboxunitprice" TextMode="Number" CssClass="form-control" runat="server" AutoPostBack="True" OnTextChanged="tboxunitprice_TextChanged"></asp:TextBox><br />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Qty<br />
                                        <asp:TextBox ID="tboxqty" TextMode="Number" CssClass="form-control" runat="server" AutoPostBack="True" OnTextChanged="tboxunitprice_TextChanged"></asp:TextBox><br />

                                    </td>
                                    <td>Net price<br />
                                        <asp:TextBox ID="tboxnetprice" TextMode="Number" CssClass="form-control" runat="server"></asp:TextBox><br />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <asp:ValidationSummary ID="ValidationSummary2" CssClass="alert alert-danger" ValidationGroup="val2" runat="server" />
                    <asp:Button ID="insertbtn" runat="server" Text="add" CssClass="btn btn-primary" OnClick="insertbtn_Click" />
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
