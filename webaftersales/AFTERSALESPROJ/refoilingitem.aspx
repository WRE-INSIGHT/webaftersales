<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="refoilingitem.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.refoilingitem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Re-foiling Item</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>Re-foiling  Proposal Item</strong></h3>
        <div class="navbar-right">
            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" PostBackUrl="~/AFTERSALESPROJ/refoilingpage.aspx" runat="server">back</asp:LinkButton>
        </div>
    </div>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="row">
        <div class="col-sm-4">
            <div class="input-group">
                <div class="input-group-addon">
                    Re-foiling/sqm
                </div>
                <asp:TextBox ID="tboxRefoilingPerSqm" TextMode="Number" CssClass="form-control" runat="server"></asp:TextBox>
                <div class="input-group-btn">
                    <asp:LinkButton ID="btnSet" CssClass="btn btn-default" runat="server" OnClick="btnSet_Click">set</asp:LinkButton>
                </div>
            </div>
        </div>
        <div class="col-sm-4">
            <div class="input-group">
                <div class="input-group-addon">
                    Cleaning/sqm
                </div>
                <asp:TextBox ID="tboxCleaningPerSqm" TextMode="Number" CssClass="form-control" runat="server"></asp:TextBox>
                <div class="input-group-btn">
                    <asp:LinkButton ID="LinkButton4" CssClass="btn btn-default" runat="server" OnClick="LinkButton4_Click">set</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
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
                            <asp:TemplateField HeaderText="Description">
                                <ItemTemplate>
                                    <asp:Label ID="Label8" runat="server" Text='<%# Bind("DESCRIPTION") %>'></asp:Label>
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
                <asp:Button ID="btnimport" CssClass="btn btn-success" runat="server" Text="import" OnClick="btnimport_Click" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="panel panel-success" style="background-color: aliceblue;">
                <div class="panel-heading">
                    <h3>Input form</h3>
                </div>
                <div class="">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="row">
                                <div class="col-xs-6">
                                    Item Number<br />
                                    <asp:TextBox ID="tboxitemno" TextMode="Number" CssClass=" form-control" runat="server"></asp:TextBox>
                                </div>
                                <div class="col-xs-6">
                                    K Number<br />
                                    <asp:TextBox ID="tboxkno" CssClass=" form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>

                            Location<br />
                            <asp:TextBox ID="tboxlocation" CssClass=" form-control" runat="server"></asp:TextBox>
                            Parts/Design<br />
                            <asp:TextBox ID="tboxparts" CssClass=" form-control" runat="server"></asp:TextBox>
                            Description<br />
                            <asp:TextBox ID="tboxdescription" CssClass=" form-control" runat="server"></asp:TextBox>
                        </div>
                        <div class="col-sm-6">
                            <div class="row">
                                <div class="col-xs-6">
                                    Article Number<br />
                                    <asp:DropDownList ID="ddlarticleno" runat="server" CssClass=" form-control" AutoPostBack="True" OnSelectedIndexChanged="ddlarticleno_SelectedIndexChanged"></asp:DropDownList>
                                </div>
                                <div class="col-xs-6">
                                    Profile length<br />
                                    <asp:TextBox ID="tboxlength" TextMode="Number" CssClass=" form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-6">
                                    Profile width inside<br />
                                    <asp:TextBox ID="tboxwidthin" TextMode="Number" CssClass=" form-control" runat="server"></asp:TextBox>
                                </div>
                                <div class="col-xs-6">
                                    Profile width outside<br />
                                    <asp:TextBox ID="tboxwidthout" TextMode="Number" CssClass=" form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-4">
                                    Quantity<br />
                                    <asp:TextBox ID="tboxqty" TextMode="Number" CssClass=" form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>

                        </div>
                    </div>
                    <br />
                    <asp:LinkButton ID="LinkButton2" CssClass="btn btn-primary" runat="server" ValidationGroup="val1" OnClick="LinkButton2_Click">add</asp:LinkButton>
                </div>
            </div>


            <div class="panel panel-success">
                <div class="panel-heading">
                    <h3>Items for re-foiling</h3>
                </div>
                <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
                    <asp:GridView ID="GridView1" runat="server" CssClass="table" AutoGenerateColumns="false" CellPadding="4" ForeColor="#333333" GridLines="Both" OnRowCommand="GridView1_RowCommand">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:TemplateField ItemStyle-Wrap="false">
                                <ItemTemplate>
                                    <asp:Panel ID="btnpanel1" runat="server">
                                        <asp:LinkButton ID="btndelete" CommandName="mydelete" OnClientClick="return confirm('delete this record?')" runat="server">delete</asp:LinkButton>
                                        |
                                    <asp:LinkButton ID="btnedit" CommandName="myedit" runat="server">edit</asp:LinkButton>
                                    </asp:Panel>
                                    <asp:Panel ID="btnpanel2" Visible="false" runat="server">
                                        <asp:LinkButton ID="btnsave" CommandName="mysave" runat="server">save</asp:LinkButton>
                                        |
                                        <asp:LinkButton ID="btncancel" CommandName="mycancel" runat="server">cancel</asp:LinkButton>
                                    </asp:Panel>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ITEM#" ItemStyle-Wrap="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblid" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                    <asp:Label ID="lblitemno" runat="server" Text='<%# Bind("ITEM_NO") %>'></asp:Label>
                                    <asp:TextBox ID="tboxitemnoE" Width="100px" TextMode="Number" Visible="false" CssClass=" form-control" Text='<%# Bind("ITEM_NO") %>' runat="server"></asp:TextBox>
                                </ItemTemplate>
                                <ItemStyle Wrap="False" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="K#" ItemStyle-Wrap="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblkno" runat="server" Text='<%# Bind("K_NO") %>'></asp:Label>
                                    <asp:TextBox ID="tboxknoE" Width="200px" CssClass="form-control" Visible="false" Text='<%# Bind("K_NO") %>' runat="server"></asp:TextBox>
                                </ItemTemplate>
                                <ItemStyle Wrap="False" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="LOCATION" ItemStyle-Wrap="false">
                                <ItemTemplate>
                                    <asp:Label ID="lbllocation" runat="server" Text='<%# Bind("LOCATION") %>'></asp:Label>
                                    <asp:TextBox ID="tboxlocationE" Width="200px" CssClass="form-control" Text='<%# Bind("LOCATION") %>' Visible="false" runat="server"></asp:TextBox>
                                </ItemTemplate>
                                <ItemStyle Wrap="False" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="PARTS" ItemStyle-Wrap="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblparts" runat="server" Text='<%# Bind("PARTS") %>'></asp:Label>
                                    <asp:TextBox ID="tboxpartsE" Width="200px" CssClass=" form-control" Visible="false" Text='<%# Bind("PARTS") %>' runat="server"></asp:TextBox>
                                </ItemTemplate>
                                <ItemStyle Wrap="False" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="DESCRIPTION" ItemStyle-Wrap="false">
                                <ItemTemplate>
                                    <asp:Label ID="lbldescription" runat="server" Text='<%# Bind("ITEM_DESCRIPTION") %>'></asp:Label>
                                    <asp:TextBox ID="tboxdescriptionE" Width="200px" CssClass=" form-control" Visible="false" Text='<%# Bind("ITEM_DESCRIPTION") %>' runat="server"></asp:TextBox>
                                </ItemTemplate>
                                <ItemStyle Wrap="False" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ARTICLE#" ItemStyle-Wrap="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblarticleno" runat="server" Text='<%# Bind("ARTICLE_NO") %>'></asp:Label>
                                    <asp:TextBox ID="tboxarticlenoE" Width="200px" CssClass=" form-control" Visible="false" Text='<%# Bind("ARTICLE_NO") %>' runat="server"></asp:TextBox>
                                </ItemTemplate>
                                <ItemStyle Wrap="False" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="PROFILE LENGTH" ItemStyle-Wrap="false">
                                <ItemTemplate>
                                    <asp:Label ID="lbllength" runat="server" Text='<%# Bind("PROFILE_LENGTH") %>'></asp:Label>
                                    <asp:TextBox ID="tboxlengthE" Width="200px" TextMode="Number" Text='<%# Bind("PROFILE_LENGTH") %>' Visible="false" CssClass=" form-control" runat="server"></asp:TextBox>
                                </ItemTemplate>
                                <ItemStyle Wrap="False" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="WIDTH INSIDE" ItemStyle-Wrap="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblinside" runat="server" Text='<%# Bind("PROFILE_WIDTH_IN") %>'></asp:Label>
                                    <asp:TextBox ID="tboxwidthinE" TextMode="Number" Text='<%# Bind("PROFILE_WIDTH_IN") %>' Visible="false" CssClass=" form-control" runat="server"></asp:TextBox>
                                </ItemTemplate>
                                <ItemStyle Wrap="False" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="WIDTH OUTSIDE" ItemStyle-Wrap="false">
                                <ItemTemplate>
                                    <asp:Label ID="lbloutside" runat="server" Text='<%# Bind("PROFILE_WIDTH_OUT") %>'></asp:Label>
                                    <asp:TextBox ID="tboxwidthoutE" TextMode="Number" Text='<%# Bind("PROFILE_WIDTH_OUT") %>' Visible="false" CssClass=" form-control" runat="server"></asp:TextBox>
                                </ItemTemplate>
                                <ItemStyle Wrap="False" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="QUANTITY" ItemStyle-Wrap="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblqty" runat="server" Text='<%# Bind("QTY") %>'></asp:Label>
                                    <asp:TextBox ID="tboxqtyE" TextMode="Number" Visible="false" Text='<%# Bind("QTY") %>' CssClass=" form-control" runat="server"></asp:TextBox>
                                </ItemTemplate>
                                <ItemStyle Wrap="False" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SUB TOTAL" ItemStyle-Wrap="false">
                                <ItemTemplate>
                                    <div class="text-right">
                                        <asp:Label ID="lblsubtotal" runat="server" Text='<%# Bind("SUB_TOTAL") %>'></asp:Label>
                                    </div>
                                </ItemTemplate>
                                <ItemStyle Wrap="False" />
                            </asp:TemplateField>
                        </Columns>
                        <EditRowStyle BackColor="#7C6F57" />
                        <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#E3EAEB" />
                        <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#F8FAFA" />
                        <SortedAscendingHeaderStyle BackColor="#246B61" />
                        <SortedDescendingCellStyle BackColor="#D4DFE1" />
                        <SortedDescendingHeaderStyle BackColor="#15524A" />
                    </asp:GridView>
                    <asp:ValidationSummary ID="ValidationSummary2" ValidationGroup="valedit" CssClass="alert alert-danger" runat="server" />
                </asp:Panel>
            </div>

        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
        <ContentTemplate>
            <div class="panel panel-success">
                <div class="panel-heading">
                    <h3>LETTER</h3>
                </div>
                <div>
                    <span>Re:
                    </span>
                    <br />
                    <asp:TextBox ID="tboxreference" CssClass="form-control" runat="server"></asp:TextBox>
                    <br />
                    <span>Salutation:
                    </span>
                    <br />
                    <asp:TextBox ID="tboxsalutation" CssClass="form-control" runat="server"></asp:TextBox>
                    <br />
                    <span>Body:
                    </span>
                    <br />
                    <asp:TextBox ID="tboxbody" TextMode="MultiLine" Rows="5" CssClass="form-control" runat="server"></asp:TextBox>
                    <br />
                    <asp:LinkButton ID="LinkButton5" CssClass="btn btn-success" runat="server" OnClick="LinkButton5_Click">save</asp:LinkButton>
                </div>
                <div>
                    <asp:ValidationSummary ID="ValidationSummary3" ValidationGroup="SUCCESSVAL" CssClass="alert alert-success" runat="server" />
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
