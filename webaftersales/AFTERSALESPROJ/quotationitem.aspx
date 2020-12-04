<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="quotationitem.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.quotationitem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quotation Items</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server"></asp:ScriptManager>
    <div class="well">
        <h3><strong>Quotation items</strong></h3>
        <div class="navbar-right">
            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" runat="server" PostBackUrl="~/AFTERSALESPROJ/quotation.aspx">back</asp:LinkButton>
        </div>
    </div>
    <h2>
        <strong>
            <asp:Label ID="lblproject" runat="server" Text="Project Name"></asp:Label>
        </strong>
        <br />
        <small>
            <asp:Label ID="lbladdress" runat="server" Text="Address"></asp:Label>
        </small></h2>
    <asp:Panel ID="Panel1" ScrollBars="Auto" runat="server">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <h4 class="text-warning"> selected quotation: </h4>
                <asp:GridView ID="GridView3" AutoGenerateColumns="false" CssClass="table" runat="server" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" OnRowCommand="GridView3_RowCommand">
                    <Columns>

                        <asp:TemplateField HeaderText="ASE #">
                            <ItemTemplate>
                                <asp:Label ID="lblid" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                <asp:Label ID="lblaseno" runat="server" Text='<%# Bind("[ASE#]") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="DATE">
                            <ItemTemplate>
                                <asp:Label ID="lbldate" runat="server" Text='<%# Bind("[DATE]") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="PARTICULAR">
                            <ItemTemplate>
                                <asp:Label ID="lblparticular" runat="server" Text='<%# Bind("[PARTICULAR]") %>'></asp:Label>
                                <asp:TextBox ID="tboxparticular" Visible="false" Text='<%# Eval("PARTICULAR") %>' runat="server"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="OTHER CHARGES">
                            <ItemTemplate>
                                <asp:Label ID="lblothercharges" runat="server" Text='<%# Bind("[OTHERCHARGES]") %>'></asp:Label>
                                <asp:TextBox ID="tboxothercharges" Visible="false" TextMode="Number" Text='<%# Eval("OTHERCHARGES") %>' runat="server"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="MOBILIZATION CHARGES">
                            <ItemTemplate>
                                <asp:Label ID="lblmobilization" runat="server" Text='<%# Bind("[MOBILIZATION]") %>'></asp:Label>
                                <asp:DropDownList ID="ddlmobi" Visible="false" runat="server" OnSelectedIndexChanged="mobiselectedindexchange" AutoPostBack="true">
                                    <asp:ListItem Value="1500">NCR</asp:ListItem>
                                    <asp:ListItem Value="3000">Southern Luzon  until Quezon boundaries</asp:ListItem>
                                    <asp:ListItem Value="3500">Northern Luzon</asp:ListItem>
                                </asp:DropDownList>
                                <asp:TextBox ID="tboxmobilization" Visible="false" TextMode="Number" Text='<%# Eval("MOBILIZATION") %>' runat="server"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="NET PRICE">
                            <ItemTemplate>
                                <asp:Label ID="lblnetprice" runat="server" Text='<%# Bind("[NETPRICE]") %>'></asp:Label>
                                <asp:TextBox ID="tboxnetprice" Visible="false" Enabled="false" Text='<%# Eval("NETPRICE") %>' runat="server"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ACTUAL PRICE">
                            <ItemTemplate>
                                <asp:Label ID="lblactualprice" runat="server" Text='<%# Bind("[ACTUALPRICE]") %>'></asp:Label>
                                <asp:LinkButton ID="equalbtn" CommandName="equal" Visible="false" runat="server">=</asp:LinkButton>
                                <asp:TextBox ID="tboxactualprice" Visible="false" TextMode="Number" Text='<%# Eval("ACTUALPRICE") %>' runat="server"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="FOC">
                            <ItemTemplate>
                                <asp:Label ID="lblfoc" runat="server" Text='<%# Bind("[FOC]") %>'></asp:Label>
                                <asp:TextBox ID="tboxfoc" Visible="false" Text='<%# Eval("FOC") %>' runat="server"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="editbtn" CommandName="myedit" runat="server">Edit</asp:LinkButton>
                                <asp:LinkButton ID="updatebtn" Visible="false" CommandName="myupdate" runat="server">Update</asp:LinkButton>
                                <asp:LinkButton ID="cancelbtn" Visible="false" CommandName="mycancel" runat="server">Cancel</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="White" ForeColor="#000066" />
                    <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" Wrap="False" />
                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                    <RowStyle ForeColor="#000066" Wrap="False" />
                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#007DBB" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#00547E" />

                </asp:GridView>


            </ContentTemplate>
        </asp:UpdatePanel>
    </asp:Panel>
    <br />
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:Label ID="lblaseno" Font-Size="XX-Large" runat="server" Text="Item table"></asp:Label>
            <asp:Panel ID="Panel2" runat="server" ScrollBars="Auto">

                <asp:GridView ID="GridView1" CssClass="table" AutoGenerateColumns="False" runat="server" OnRowCommand="GridView1_RowCommand" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" PageSize="15" CellSpacing="1" OnPageIndexChanging="GridView1_PageIndexChanging" AllowPaging="True">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                             
                                <asp:LinkButton ID="LinkButton2" runat="server" CommandName="myedit">Edit</asp:LinkButton>
                                <asp:LinkButton ID="LinkButton3" runat="server" OnClientClick="return confirm('delete this record?')" CommandName="mydelete">Delete</asp:LinkButton>
                                <asp:LinkButton ID="LinkButton5" Visible="false" runat="server" CommandName="mysave">Update</asp:LinkButton>
                                <asp:LinkButton ID="LinkButton6" Visible="false" runat="server" CommandName="myclose">Cancel</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton4" runat="server" CommandName="parts">Items</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="LOCATION">
                            <ItemTemplate>
                                <asp:Label ID="idlbl" runat="server" Visible="false" Text='<%# Bind("ID") %>'></asp:Label>
                                <asp:Label ID="locationlbl" runat="server" Text='<%# Bind("LOCATION") %>'></asp:Label>
                                <asp:TextBox ID="editlocationtbox" Visible="false" Text='<%# Eval("LOCATION") %>' runat="server"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="K #">
                            <ItemTemplate>
                                <asp:Label ID="knolbl" runat="server" Text='<%# Bind("KNO") %>'></asp:Label>
                                <asp:TextBox ID="editknotbox" Visible="false" Text='<%# Eval("KNO") %>' runat="server"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ITEM #">
                            <ItemTemplate>
                                <asp:Label ID="itemnolbl" runat="server" Text='<%# Bind("itemno") %>'></asp:Label>
                                <asp:TextBox ID="edititemnotbox" Visible="false" Text='<%# Eval("itemno") %>' runat="server"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="NET PRICE">
                            <ItemTemplate>
                                <asp:Label ID="netpricelbl" runat="server" Text='<%# Bind("netprice") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:GridView ID="GridView2" Visible="false" AutoGenerateColumns="False" DataSource='<%# Bind("thisparts") %>' runat="server" OnRowCommand="GridView2_RowCommand" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black">
                                    <Columns>
                                        <asp:TemplateField HeaderText="ARTICLE #">
                                            <ItemTemplate>
                                                <asp:Label ID="partsidlbl" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                                <asp:LinkButton runat="server" CommandName="g2mydelete" OnClientClick="return confirm('delete this record?')">Delete</asp:LinkButton>&nbsp;
                                                                        <asp:Label ID="articlenolbl" runat="server" Text='<%# Bind("ARTICLENO") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="DESCRIPTION">
                                            <ItemTemplate>
                                                <asp:Label ID="descriptionlbl" runat="server" Text='<%# Bind("DESCRIPTION") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="%MARKUP">
                                            <ItemTemplate>
                                                <asp:Label ID="markuplbl" runat="server" Text='<%# Bind("MARKUP") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="UNIT PRICE">
                                            <ItemTemplate>
                                                <asp:Label ID="unitpricelbl" runat="server" Text='<%# Bind("UNITPRICE") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="QTY">
                                            <ItemTemplate>
                                                <asp:Label ID="qtylbl" runat="server" Text='<%# Bind("QTY") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="NET AMOUNT">
                                            <ItemTemplate>
                                                <asp:Label ID="netamountlbl" runat="server" Text='<%# Bind("netamount") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                    </Columns>
                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                    <RowStyle Wrap="false" BackColor="White" />
                                    <FooterStyle BackColor="#CCCCCC" />
                                    <HeaderStyle Wrap="false" BackColor="Black" Font-Bold="True" ForeColor="White" />
                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                    <SortedDescendingHeaderStyle BackColor="#383838" />
                                </asp:GridView>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                    <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                    <HeaderStyle Wrap="False" BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />
                    <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
                    <RowStyle Wrap="False" BackColor="#DEDFDE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#594B9C" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#33276A" />
                    <PagerSettings PageButtonCount="8" />
                    <PagerStyle CssClass="GridPager" HorizontalAlign="Left" ForeColor="Black" />
                    <EmptyDataTemplate>
                        <div class="alert alert-danger">
                            <h2><strong>Empty Table!</strong>
                                <small>0 result found</small>
                            </h2>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>

            </asp:Panel>

            <div class="panel panel-default">
                <div class="panel-body">

                    <div class="row">
                        <div class="col-sm-4">
                            Item #<br />
                            <asp:TextBox ID="itemnotbox" CssClass="form-control" placeholder="Item number" runat="server"></asp:TextBox>
                            <br />
                        </div>
                        <div class="col-sm-4">
                            K #<br />
                            <asp:TextBox ID="knotbox" CssClass="form-control" placeholder="K number" runat="server"></asp:TextBox>
                            <br />
                        </div>
                        <div class="col-sm-4">
                            Location<br />
                            <asp:TextBox ID="locationtbox" CssClass="form-control" placeholder="Location" runat="server"></asp:TextBox>
                            <br />
                        </div>
                    </div>
                    <asp:Button ID="Button1" runat="server" Text="add" CssClass="btn btn-primary" OnClick="Button1_Click" />
                    <asp:Button ID="Button3" runat="server" Text="import" CssClass="btn btn-default" OnClick="Button3_Click" />
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>


</asp:Content>
