<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="CallinPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.CallinPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Call-in</title>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="well">
        <table>
            <tr>
                <td>
                    <h3><strong>Call-in Records</strong></h3>
                </td>
                <td>
                    <asp:LinkButton ID="LinkButton3" runat="server" OnClick="LinkButton3_Click">new</asp:LinkButton></td>
            </tr>
        </table>
        <div class="row">
            <div class="col-sm-6">
                <div class="input-group">
                    <div class="input-group-addon">
                        Province
                    </div>
                    <asp:DropDownList ID="provinceddl" CssClass="form-control" runat="server"></asp:DropDownList><br />
                </div>
            </div>
            <div class="col-sm-6">
                <div class="input-group">
                    <asp:TextBox ID="callinkey" CssClass="form-control" runat="server"></asp:TextBox>
                    <div class="input-group-btn">
                        <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" runat="server" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton><br />
                    </div>
                </div>
            </div>

        </div>

    </div>


    <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="val1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>


            <asp:GridView ID="GridView1" GridLines="None" runat="server" AllowPaging="True" AutoGenerateColumns="False" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <div class='<%# Eval("TURNOVER").ToString() == "0" ? "panel panel-success" : Convert.ToDecimal(Eval("PAYMENTPER")) >=100 ? "panel panel-success" : Eval("RSTATUS").ToString() == "Approved" ? "panel panel-success" : "panel panel-default" %>'>
                                <div class="panel-heading">
                                    <asp:LinkButton ID="LinkButton2" CommandName="myedit" Font-Size="Medium" runat="server">Edit</asp:LinkButton>
                                    <div class="navbar-right">
                                        <asp:Label ID="callinlbl" Font-Size="Medium" runat="server" Text='<%# Bind("CIN") %>'></asp:Label>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <div class="row">

                                        <div class="col-sm-6">
                                            <asp:Label ID="callinidlbl" runat="server" Visible="false" Text='<%# Eval("AUTONUM") %>'></asp:Label>


                                            <strong>
                                                <asp:Label ID="projectlbl" Font-Size="Large" runat="server" Text='<%# Bind("PROJECT") %>'></asp:Label></strong>
                                            <br />
                                            <asp:Label ID="addresslbl" Font-Size="Medium" runat="server" Text='<%# Bind("ADDRESS") %>'></asp:Label>
                                            <br />
                                            <asp:LinkButton ID="editaddressbtn" CommandName="editaddressbtn" runat="server">edit address</asp:LinkButton>
                                            <br />
                                            <asp:Panel ID="UPDATEADDRESSPANEL" Visible="false" ScrollBars="Auto" runat="server">
                                                <div class="panel panel-danger">
                                                    <div class="panel-heading">
                                                        UPDATE ADDRESS
                                            <asp:Label ID="tboxParentjono" runat="server" Visible="false" Text='<%# Bind("PARENTJONO") %>'></asp:Label>
                                                    </div>
                                                    <div class="panel-body">
                                                        <table border="0" class="table">
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
                                                                    <asp:LinkButton ID="saveaddressbtn" CommandName="saveaddressbtn" runat="server" CssClass="btn btn-primary">save</asp:LinkButton>
                                                                    <asp:LinkButton ID="canceladdressbtn" CommandName="canceladdressbtn" CssClass="btn btn-default" runat="server">cancel</asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <div class="panel-footer">
                                                    </div>

                                                </div>


                                            </asp:Panel>
                                            <table border="0" class="table">
                                                <tr>
                                                    <th><small>JO</small>
                                                    </th>
                                                    <th><small>JO DATE</small>

                                                    </th>
                                                    <th>
                                                        <small>%PAYMENT</small>
                                                    </th>
                                                    <th>
                                                        <small>Turn Over</small>
                                                    </th>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="jolbl" Font-Size="Small" runat="server" Text='<%# Eval("JO") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label10" Font-Size="Small" runat="server" Text='<%# Bind("JODATE") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="paymentperlbl" Font-Size="Small" CssClass="text-warning" runat="server" Text='<%# Bind("PAYMENTPER") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="turnoverlbl" Font-Size="Small" runat="server" Text='<%# Eval("TURNOVER").ToString() == "0" ? "Yes" : "No" %>'></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                            <asp:Label ID="datelbl" Font-Size="XX-Large" runat="server" Text='<%# Bind("DATE") %>'></asp:Label>
                                            <br />
                                            <table border="1" class="table">

                                                <tr>
                                                    <td class="text-muted"><small>Status</small> </td>
                                                    <td>
                                                        <asp:Label ID="statuslbl" Font-Size="Medium" runat="server" Text='<%# Bind("STATUS") %>'></asp:Label></td>

                                                </tr>
                                                <tr>
                                                    <td class="text-muted"><small>Concern</small></td>

                                                    <td>
                                                        <asp:Label ID="concernlbl" runat="server" Text='<%# Eval("CONCERN") %>'></asp:Label>
                                                    </td>

                                                </tr>
                                                <tr>
                                                    <td class="text-muted"><small>Conversation</small> </td>
                                                    <td>
                                                        <asp:Label ID="conversationlbl" runat="server" Text='<%# Eval("CONVERSATION") %>'></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="text-muted"><small>Color</small> </td>
                                                    <td>
                                                        <asp:Label ID="lblProfileFinish" runat="server" Text='<%# Eval("[PROFILE FINISH]") %>'></asp:Label>
                                                        <asp:LinkButton ID="btnEditColor" CommandName="editColor" runat="server">edit</asp:LinkButton>
                                                        <asp:Panel ID="pnlColor" Visible="false" runat="server">
                                                            <table>
                                                                <tr>
                                                                    <td>Select Color</td>
                                                                    <td>
                                                                        <div class="input-group">
                                                                            <asp:DropDownList ID="ddlColor" CssClass="form-control" runat="server">
                                                                            </asp:DropDownList>
                                                                            <div class="input-group-btn">
                                                                                <asp:LinkButton ID="btnSelectColor" CommandName="selectColor" CssClass="btn btn-default" runat="server">select</asp:LinkButton>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>Color</td>
                                                                    <td>
                                                                        <asp:TextBox ID="tboxColor" CssClass="form-control" runat="server" Text='<%# Bind("[PROFILE FINISH]") %>'></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2">
                                                                        <asp:LinkButton ID="btnSaveColor" CssClass="btn btn-success" CommandName="saveColor" runat="server">save</asp:LinkButton>
                                                                        <asp:LinkButton ID="btnCancelColor" CssClass="btn btn-warning" CommandName="cancelEditingColor" runat="server">cancel</asp:LinkButton>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                            </table>

                                            <asp:LinkButton ID="LinkButton6" runat="server" CommandName="myphotos" CssClass="btn btn-warning">photos</asp:LinkButton>

                                        </div>
                                        <div class="col-sm-6">
                                            <div class="panel panel-default">
                                                <table class="table">
                                                    <tr>
                                                        <th>EIC</th>
                                                        <th>AEIC</th>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("EIC") %>'></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label3" runat="server" Text='<%# Eval("AEIC") %>'></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2"></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <strong class="text-center">Contact Details</strong>
                                                            <br />
                                                            <table>
                                                                <tr>
                                                                    <td><small class="text-muted">Caller :&nbsp;</small>
                                                                        <asp:Label ID="callerlbl" Font-Size="15px" runat="server" Text='<%# Bind("CALLER") %>'></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td><small class="text-muted">Contact person :&nbsp;</small>
                                                                        <asp:Label ID="contactpersonlbl" runat="server" Text='<%# Eval("CONTACTPERSON") %>'></asp:Label></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><small class="text-muted">Tel #</small> :&nbsp;</small>
                                                                <asp:Label ID="telnolbl" runat="server" Text='<%# Eval("TELNO") %>'></asp:Label></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><small class="text-muted">Email</small> :&nbsp;</small>
                                                                <asp:Label ID="emaillbl" runat="server" Text='<%# Eval("EMAIL") %>'></asp:Label></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><small class="text-muted">Viber</small> :&nbsp;</small>
                                                                <asp:Label ID="viberlbl" runat="server" Text='<%# Eval("VIBER") %>'></asp:Label></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><small class="text-muted">WhatsApp</small>  :&nbsp;</small>
                                                                <asp:Label ID="whatsapplbl" runat="server" Text='<%# Eval("WHATSAPP") %>'></asp:Label></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><small class="text-muted">Fax #</small>  :&nbsp;</small>
                                                                <asp:Label ID="faxnolbl" runat="server" Text='<%# Eval("FAXNO") %>'></asp:Label></td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>

                                            </div>
                                            <asp:LinkButton ID="LinkButton4" CommandName="myservicing"
                                                CssClass='<%# Eval("TURNOVER").ToString() == "0" ? "btn btn-primary" : Convert.ToDecimal(Eval("PAYMENTPER")) >=100 ? "btn btn-primary" : Eval("RSTATUS").ToString() == "Approved" ? "btn btn-primary" : "btn btn-default" %>'
                                                Visible='<%# Eval("TURNOVER").ToString() == "0" ? true : Convert.ToDecimal(Eval("PAYMENTPER")) >=100 ? true : Eval("RSTATUS").ToString() == "Approved" ? true : false %>'
                                                runat="server">job order</asp:LinkButton>
                                            <br />
                                            <asp:LinkButton ID="LinkButton5" CommandName="requestcollection" CssClass='<%# Eval("REQUESTED").ToString() == "" ? "btn btn-danger" : "btn btn-success" %>'
                                                Visible='<%# Eval("TURNOVER").ToString() == "0" ? false : Convert.ToDecimal(Eval("PAYMENTPER")) >=100 ? false : Eval("RSTATUS").ToString() == "" ? true : false %>'
                                                Text='<%# Eval("REQUESTED").ToString() == "" ? "request for jo approval" : "requested "+Eval("REQUESTED").ToString() %>' runat="server">request for collection review</asp:LinkButton>

                                            <asp:Panel ID="Panel3" runat="server" Visible='<%# Eval("RSTATUS").ToString() == "" ? false : true  %>'>
                                                <asp:Label ID="lblrstatus" Font-Size="X-Large" runat="server" CssClass='<%# Eval("RSTATUS").ToString() == "Approved" ? "text-success" : "text-danger" %>'
                                                    Text='<%# Bind("[RSTATUS]") %>'></asp:Label>&nbsp
                                        <asp:Label ID="Label5" runat="server" Text='<%# Eval("RSTATUS").ToString()=="Approved" ? Eval("APPROVED").ToString() : Eval("DISAPPROVED").ToString() %>'></asp:Label>
                                                <br />
                                                <blockquote>
                                                    <asp:Label ID="Label6" CssClass="text-muted" runat="server" Text='<%# Bind("MESSAGE") %>'></asp:Label>
                                                </blockquote>
                                            </asp:Panel>

                                        </div>
                                    </div>

                                </div>
                            </div>
                        </ItemTemplate>

                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="alert alert-danger">
                        <h2><strong>Empty Table!</strong>
                            <small>0 result found</small>
                        </h2>
                    </div>
                </EmptyDataTemplate>
                <PagerSettings PageButtonCount="8" />
                <PagerStyle CssClass="GridPager" HorizontalAlign="Left" />
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
