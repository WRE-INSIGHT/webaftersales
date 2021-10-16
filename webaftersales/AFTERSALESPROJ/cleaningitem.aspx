<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="cleaningitem.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.cleaningitem" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Cleaning Item</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>Cleaning Proposal Item</strong></h3>
        <div class="navbar-right">
            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" PostBackUrl="~/AFTERSALESPROJ/cleaningpage.aspx" runat="server">back</asp:LinkButton>
        </div>
    </div>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<%--    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
        <ContentTemplate>--%>
            <div class="row">
                <div class="col-sm-3">
                    <div class="input-group">
                        <div class="input-group-addon">
                            Unit price
                        </div>
                        <asp:TextBox ID="tboxCleaningUnitPrice" TextMode="Number" CssClass="form-control" runat="server"></asp:TextBox>
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSet" CssClass="btn btn-default" runat="server" OnClick="btnSet_Click">set</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
       <%-- </ContentTemplate>
    </asp:UpdatePanel>--%>
    <br />
    <br />
    <div style="background-color: aliceblue;" class="panel panel-success">
        <div class="panel-heading">
            <h3>Import form <small class="text-muted">(DMS generated data)</small></h3>
        </div>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>

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
                                <asp:LinkButton ID="LinkButton3" CssClass="btn btn-default" Height="30" runat="server" OnClick="searchbtn_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
                <br />
                <asp:Panel ID="Panel2" runat="server" ScrollBars="Auto">
                    <asp:GridView ID="GridView2" CssClass="table" runat="server"
                        AutoGenerateColumns="False" EmptyDataText="No result found."
                        AllowPaging="True" DataKeyNames="ID"
                        OnPageIndexChanging="GridView2_PageIndexChanging"
                        OnRowDataBound="GridView2_RowDataBound" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Both">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Label ID="Label6" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                    <asp:CheckBox ID="cboxselect" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Location">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("LOCATION") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="K #">
                                <ItemTemplate>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("KMDI_NO") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Item #">
                                <ItemTemplate>
                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("ITEM_NO") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="JO">
                                <ItemTemplate>
                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("job_order_no") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Dimension">
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("WIDTH") %>'></asp:Label>&nbsp;x&nbsp;<asp:Label ID="Label7" runat="server" Text='<%# Bind("HEIGHT") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                        <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" Wrap="False" />
                        <PagerStyle CssClass="GridPager" HorizontalAlign="Right" BackColor="White" ForeColor="Black" />
                        <EmptyDataTemplate>
                            <div class="">
                                <h2><strong>This table is empty!</strong>
                                    <small>There are no k#(s) inputs in the original system.</small>
                                </h2>
                            </div>
                        </EmptyDataTemplate>
                        <RowStyle Wrap="False" />
                        <SortedAscendingCellStyle BackColor="#F7F7F7" />
                        <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                        <SortedDescendingCellStyle BackColor="#E5E5E5" />
                        <SortedDescendingHeaderStyle BackColor="#242121" />
                    </asp:GridView>
                </asp:Panel>
                <br />
                <asp:Button ID="btnimport" CssClass="btn btn-success" runat="server" OnClick="btnimport_Click" Text="import" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <div class="panel panel-success" style="background-color: aliceblue;">
        <div class="panel-heading">
            <h3>Input form</h3>
        </div>
        <div class="">
            <div class="row">
                <div class="col-sm-6">
                    Location<br />
                    <asp:TextBox ID="tboxlocation" CssClass=" form-control" runat="server"></asp:TextBox>
                    Area<br />
                    <asp:TextBox ID="tboxarea" TextMode="Number" CssClass=" form-control" runat="server"></asp:TextBox>
                </div>
                <div class="col-sm-6">
                    Unit Price          
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="tboxunitprice" ValidationGroup="val1" runat="server" ErrorMessage="unit price is required!" ForeColor="Red">*</asp:RequiredFieldValidator><br />
                    <asp:TextBox ID="tboxunitprice" TextMode="Number" CssClass=" form-control" runat="server"></asp:TextBox>
                    Qty  
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="tboxqty" ValidationGroup="val1" runat="server" ErrorMessage="qty is required!" ForeColor="Red">*</asp:RequiredFieldValidator><br />
                    <asp:TextBox ID="tboxqty" TextMode="Number" CssClass=" form-control" runat="server"></asp:TextBox>
                </div>
            </div>
            <br />
            <asp:LinkButton ID="LinkButton2" CssClass="btn btn-primary" runat="server" ValidationGroup="val1" OnClick="LinkButton2_Click">add</asp:LinkButton>
        </div>

    </div>

    <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
        <div class="panel panel-success">
            <div class="panel-heading">
                <h3>Items for cleaning</h3>
            </div>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table" OnRowCommand="GridView1_RowCommand" CellPadding="4" ForeColor="#333333" GridLines="Both">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton CssClass="btn btn-warning" CommandName="myedit" ID="btnedit" runat="server">edit</asp:LinkButton>
                                    <asp:LinkButton CssClass="btn btn-danger" CommandName="mydelete" ID="btndelete" OnClientClick="return confirm('delete this record?');" runat="server">delete</asp:LinkButton>
                                    <asp:LinkButton CssClass="btn btn-success" CommandName="mysave" ValidationGroup="valedit" ID="btnsave" Visible="false" runat="server">save</asp:LinkButton>
                                    <asp:LinkButton CssClass="btn btn-default" CommandName="mycancel" ID="btncancel" Visible="false" runat="server">cancel</asp:LinkButton>
                                    <asp:Label ID="lblid" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                    <asp:Label ID="lbliid" Visible="false" runat="server" Text='<%# Bind("IID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="LOCATION">
                                <ItemTemplate>
                                    <asp:Label ID="lbllocation" runat="server" Text='<%# Bind("LOCATION") %>'></asp:Label>
                                    <asp:TextBox ID="tboxlocationedit" CssClass="form-control" Visible="false" runat="server" Text='<%# Bind("LOCATION") %>'></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="AREA">
                                <ItemTemplate>
                                    <asp:Label ID="lblarea" runat="server" Text='<%# Bind("AREA") %>'></asp:Label>
                                    <asp:TextBox ID="tboxareaedit" CssClass="form-control" TextMode="Number" Visible="false" runat="server" Text='<%# Bind("AREA") %>'></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="UNIT PRICE">
                                <ItemTemplate>
                                    <asp:Label ID="lblunitprice" runat="server" Text='<%# Bind("UNITPRICE") %>'></asp:Label>
                                    <asp:TextBox ID="tboxunitpriceedit" CssClass="form-control" TextMode="Number" Visible="false" runat="server" Text='<%# Bind("UNITPRICE") %>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" Visible="false" ControlToValidate="tboxunitpriceedit" ValidationGroup="valedit" runat="server" ErrorMessage="unit price is required!" ForeColor="Red">*</asp:RequiredFieldValidator>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="QTY">
                                <ItemTemplate>
                                    <asp:Label ID="lblqty" runat="server" Text='<%# Bind("QTY") %>'></asp:Label>
                                    <asp:TextBox ID="tboxqtyedit" CssClass="form-control" TextMode="Number" Visible="false" runat="server" Text='<%# Bind("QTY") %>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" Visible="false" ControlToValidate="tboxqtyedit" ValidationGroup="valedit" runat="server" ErrorMessage="qty is required!" ForeColor="Red">*</asp:RequiredFieldValidator>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="TOTAL AMOUNT">
                                <ItemTemplate>
                                    <asp:Label ID="lbltotalamount" runat="server" Text='<%# Bind("TOTALAMOUNT") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle Wrap="false" BackColor="#E3EAEB" />
                        <EditRowStyle BackColor="#7C6F57" />
                        <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle Wrap="false" BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#F8FAFA" />
                        <SortedAscendingHeaderStyle BackColor="#246B61" />
                        <SortedDescendingCellStyle BackColor="#D4DFE1" />
                        <SortedDescendingHeaderStyle BackColor="#15524A" />
                    </asp:GridView>
                    <asp:ValidationSummary ID="ValidationSummary2" ValidationGroup="valedit" CssClass="alert alert-danger" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </asp:Panel>

</asp:Content>
