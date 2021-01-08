<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="projectList.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.projectList" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>KMDI Projects</title>
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="well">
        <h3><strong>KMDI Projects</strong></h3>
        <div class="navbar-right">
            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" PostBackUrl="~/AFTERSALESPROJ/newcallin.aspx" runat="server">back</asp:LinkButton>
        </div>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="row" style="background-color: whitesmoke">
                <div class="col-sm-6">
                             <asp:Label ID="lblEditMode" Visible="false" runat="server" Font-Bold="true" Font-Size="Larger" CssClass="text-danger" Text="Editing Mode"></asp:Label>
                    <table class="table" border="0">
                        <tr>
                            <td colspan="2"><strong>Project Details</strong> </td>
                        </tr>
                        <tr>
                            <td style="width: 150px">Client's name:
                            </td>
                            <td>
                                <asp:TextBox ID="tboxClientsName" CssClass="form-control" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Company name:
                            </td>
                            <td>
                                <asp:TextBox ID="tboxCompanyName" CssClass="form-control" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>File Label</td>
                            <td>
                                <asp:DropDownList ID="ddlFileLabel" CssClass="form-control" runat="server">
                                    <asp:ListItem Text="Proj/Client`s Name" Value="Proj/Client`s Name"></asp:ListItem>
                                    <asp:ListItem Text="Company Name" Value="Company Name"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>AEIC</td>
                            <td>
                                <asp:DropDownList ID="ddlAEIC" CssClass="form-control" runat="server">
                                </asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td>Engr.</td>
                            <td>
                                <asp:DropDownList ID="ddlEngr" CssClass="form-control" runat="server">
                                </asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td colspan="2"><strong>References</strong></td>
                        </tr>
                        <tr>
                            <td>Job Order#</td>
                            <td>
                                <asp:TextBox ID="tboxJO" CssClass="form-control" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="tboxJO" CssClass="text-danger" ValidationGroup="inputVal" runat="server" ErrorMessage="JO is required!"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>JO# Date</td>
                            <td>
                                <asp:TextBox ID="tboxJODate" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="tboxJODate" CssClass="text-danger" ValidationGroup="inputVal" runat="server" ErrorMessage="JO Date is required!"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>Quotation ref#</td>
                            <td>
                                <asp:TextBox ID="tboxQuotationRefNo" CssClass="form-control" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>Quotation Date</td>
                            <td>
                                <asp:TextBox ID="tboxQuotationDate" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="2"><strong>Profile Finish</strong>
                            </td>
                        </tr>
                        <tr>
                            <td>Select Color</td>
                            <td>
                                <div class="input-group">
                                    <asp:DropDownList ID="ddlColor" CssClass="form-control" runat="server">
                                    </asp:DropDownList>
                                    <div class="input-group-btn">
                                        <asp:LinkButton ID="btnSelectColor" CssClass="btn btn-default" runat="server" OnClick="btnSelectColor_Click">select</asp:LinkButton>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>Color</td>
                            <td>
                                <asp:TextBox ID="tboxColor" CssClass="form-control" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-sm-6">
                    <table class="table" border="0">
                        <tr>
                            <td colspan="2"><strong>Site Address</strong> </td>
                        </tr>
                        <tr>
                            <td style="width: 100px">Unit no.:
                            </td>
                            <td>
                                <asp:TextBox ID="tboxUnitno" placeholder="Unit no." CssClass="form-control" Text='<%# Bind("UNITNO") %>' runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Establishment: 
                            </td>
                            <td>
                                <asp:TextBox ID="tboxEstablishment" placeholder="Establishment" CssClass="form-control" Text='<%# Bind("ESTABLISHMENT") %>' runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>No.:
                            </td>
                            <td>
                                <asp:TextBox ID="tboxNo" placeholder="No." CssClass="form-control" Text='<%# Bind("NO") %>' runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Street:</td>
                            <td>
                                <asp:TextBox ID="tboxStreet" placeholder="Street" CssClass="form-control" Text='<%# Bind("STREET") %>' runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Village:
                            </td>
                            <td>
                                <asp:TextBox ID="tboxVillage" placeholder="Village" CssClass="form-control" Text='<%# Bind("VILLAGE") %>' runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Brgy.: </td>
                            <td>
                                <asp:TextBox ID="tboxBrgy" placeholder="Brgy" CssClass="form-control" Text='<%# Bind("BRGY_MUNICIPALITY") %>' runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Town/City: </td>
                            <td>
                                <asp:TextBox ID="tboxTown" placeholder="Town" CssClass="form-control" Text='<%# Bind("TOWN_DISTRICT") %>' runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Province:   </td>
                            <td>
                                <asp:TextBox ID="tboxProvince" placeholder="Province" CssClass="form-control" Text='<%# Bind("PROVINCE") %>' runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Area:</td>
                            <td>
                                <asp:TextBox ID="tboxArea" placeholder="Area" CssClass="form-control" Text='<%# Bind("AREA") %>' runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:LinkButton ID="btnSave" CssClass="btn btn-primary" ValidationGroup="inputVal" runat="server" OnClick="btnSave_Click">add</asp:LinkButton>
                                <asp:LinkButton ID="btnUpdate" Visible="false" CssClass="btn btn-success" ValidationGroup="inputVal" runat="server" OnClick="btnUpdate_Click">update</asp:LinkButton>
                                <asp:LinkButton ID="btnCancel" Visible="false" CssClass="btn btn-warning" ValidationGroup="inputVal" runat="server" OnClick="btnCancel_Click">cancel</asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                    <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="inputVal" CssClass="alert alert-danger" runat="server" />
                </div>
            </div>
            <br />

            <asp:Panel ID="Panel1" runat="server">
       
                <div class="well">
                    <div class="input-group">
                        <div class="input-group-addon">
                            search project
                        </div>
                        <asp:TextBox ID="tboxSearch" CssClass="form-control" runat="server"></asp:TextBox>
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearch" CssClass="btn btn-primary" runat="server" OnClick="btnSearch_Click"><span class="glyphicon glyphicon-search"></span>&nbsp;Find</asp:LinkButton>
                        </div>
                    </div>
                </div>
                <h2>PROJECT TABLE</h2>
                <asp:GridView ID="GridView1" CssClass="table" BorderStyle="Solid" BorderWidth="3px" runat="server" AllowPaging="True" AutoGenerateColumns="False" OnRowCommand="GridView1_RowCommand" BackColor="#CCCCCC" BorderColor="#999999" CellPadding="4" CellSpacing="2" ForeColor="Black" OnPageIndexChanging="GridView1_PageIndexChanging">
                    <Columns>

                        <asp:TemplateField HeaderText="PROJECT DETAILS">
                            <ItemTemplate>

                                <asp:Label ID="lblProjectLabel" Visible="false" runat="server" Text='<%# Bind("PROJECT_LABEL") %>'></asp:Label>

                                <table>
                                    <tr>
                                        <td class="text-muted" style="width: 150px">Client's Name :
                                        </td>
                                        <td>
                                            <asp:Label ID="lblClientsName" runat="server" Text='<%# Bind("CLIENTS_NAME") %>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="text-muted">Company Name :
                                        </td>
                                        <td>
                                            <asp:Label ID="lblCompanyName" runat="server" Text='<%# Bind("COMPANY_NAME") %>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="text-muted">File Label :</td>
                                        <td>
                                            <asp:Label ID="lblFileLabel" runat="server" Text='<%# Bind("FILE_LABEL_AS") %>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="text-muted">AEIC :</td>
                                        <td>
                                            <asp:Label ID="lblAEIC" runat="server" Text='<%# Bind("ACCT_EXEC_INCHARGE") %>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="text-muted">Engr. :</td>
                                        <td>
                                            <asp:Label ID="lblEngr" runat="server" Text='<%# Bind("PROJECT_ENGR_INCHARGE") %>'></asp:Label></td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="REFERENCES" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <table>
                                    <tr>
                                        <td class="text-muted">Job Order# :</td>
                                        <td>
                                            <asp:Label ID="lblJO" runat="server" Text='<%# Bind("JOB_ORDER_NO") %>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="text-muted">JO# Date :</td>
                                        <td>
                                            <asp:Label ID="lblJODate" runat="server" Text='<%# Bind("JOB_ORDER_NO_DATE") %>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="text-muted">Quotation ref# :</td>
                                        <td>
                                            <asp:Label ID="lblQuotationRefNO" runat="server" Text='<%# Bind("QUOTE_REF_NO") %>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="text-muted">Quotation Date :</td>
                                        <td>
                                            <asp:Label ID="lblQuotationDate" runat="server" Text='<%# Bind("QUOTATION_DATE") %>'></asp:Label></td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                            <ItemStyle Wrap="False" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="PROFILE FINISH">
                            <ItemTemplate>
                                <asp:Label ID="lblProfileColor" runat="server" Text='<%# Bind("PROFILE_FINISH") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="SITE ADDRESS">
                            <ItemTemplate>
                                <asp:Label ID="lblUnitno" Visible="false" runat="server" Text='<%# Bind("UNITNO") %>'></asp:Label>
                                <asp:Label ID="lblEstablishment" Visible="false" runat="server" Text='<%# Bind("ESTABLISHMENT") %>'></asp:Label>
                                <asp:Label ID="lblNo" Visible="false" runat="server" Text='<%# Bind("NO") %>'></asp:Label>
                                <asp:Label ID="lblStreet" Visible="false" runat="server" Text='<%# Bind("STREET") %>'></asp:Label>
                                <asp:Label ID="lblVillage" Visible="false" runat="server" Text='<%# Bind("VILLAGE") %>'></asp:Label>
                                <asp:Label ID="lblBrgy" Visible="false" runat="server" Text='<%# Bind("BRGY_MUNICIPALITY") %>'></asp:Label>
                                <asp:Label ID="lblTown" Visible="false" runat="server" Text='<%# Bind("TOWN_DISTRICT") %>'></asp:Label>
                                <asp:Label ID="lblProvince" Visible="false" runat="server" Text='<%# Bind("PROVINCE") %>'></asp:Label>
                                <asp:Label ID="lblArea" Visible="false" runat="server" Text='<%# Bind("AREA") %>'></asp:Label>
                                <asp:Label ID="lblFulladd" runat="server" Text='<%# Bind("FULLADD") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                  <asp:LinkButton ID="LinkButton4" CommandName="selectCommand" runat="server">Select</asp:LinkButton>
                                <asp:LinkButton ID="LinkButton2" CommandName="editCommand" runat="server">Edit</asp:LinkButton>
                                <asp:LinkButton ID="LinkButton3" CommandName="deleteCommand" OnClientClick="return confirm('Delete this input?')" runat="server">Delete</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" />
                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                    <PagerSettings PageButtonCount="8" Position="TopAndBottom" />
                    <PagerStyle CssClass="GridPager" BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                    <RowStyle BackColor="White" />
                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#808080" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#383838" />
                </asp:GridView>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

