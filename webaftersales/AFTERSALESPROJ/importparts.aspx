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
                            <h2><strong>Sorry, no data available!</strong>
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
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:Panel ID="Panel1" runat="server" ScrollBars="Horizontal">
                <asp:GridView ID="GridView1" CssClass="table" AutoGenerateColumns="False" AllowPaging="True" runat="server" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black" OnPageIndexChanging="GridView1_PageIndexChanging">
                    <Columns>
                        <asp:TemplateField HeaderText="Article #">
                            <ItemTemplate>
                                <asp:Label ID="Label1" Visible="false" runat="server" Text='<%# Bind("id") %>'></asp:Label>
                                <asp:Label ID="Label2" Visible="false" runat="server" Text='<%# Bind("iid") %>'></asp:Label>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("articleno") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description">
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("description") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="%Markup">
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("markup") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Unit price">
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("unitprice") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Qty">
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("qty") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Net price">
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("netamount") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" />
                    <HeaderStyle Wrap="False" BackColor="Black" Font-Bold="True" ForeColor="White" />
                    <PagerSettings PageButtonCount="8" />
                    <PagerStyle CssClass="GridPager" HorizontalAlign="Left" ForeColor="Black" />
                    <EmptyDataTemplate>
                        <div class="alert alert-danger">
                            <h2><strong>Sorry, no data available!</strong>
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
            </asp:Panel>

            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-sm-6">
                            <asp:Label ID="Label4" Font-Size="X-Large" runat="server" Text="manual input"></asp:Label><br />
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
