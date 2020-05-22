<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/DAILYHEALTHPROFILE/DHPmaster.Master" CodeBehind="dhppage3.aspx.cs" Inherits="webaftersales.DAILYHEALTHPROFILE.dhppage3" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>DHP page 3</title>
</asp:Content>



<asp:Content ID="content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="well">
        <h3><strong>Page 3</strong></h3>
        <div class="navbar-right">
            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" PostBackUrl="~/DAILYHEALTHPROFILE/dhphome.aspx" runat="server">back</asp:LinkButton>
        </div>
    </div>
    <h3 class="text-info">EMPLOYEE DAILY HEALTH PROFILE</h3>
    <h4>RECORD DATE:
            <asp:Label ID="lbldate" runat="server" Text="Label"></asp:Label></h4>
    <blockquote>
        <h4>
            <table border="0">
                <tr>
                    <td class="text-muted">NAME
                    </td>
                    <td>
                        <asp:Label ID="lblname" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="text-muted">EMPLOYEE NO.
                    </td>
                    <td>
                        <asp:Label ID="lblempno" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="text-muted">BIRTHDATE
                    </td>
                    <td>
                        <asp:Label ID="lblbirthday" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="text-muted">AGE
                    </td>
                    <td>
                        <asp:Label ID="lblage" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
            </table>
        </h4>
    </blockquote>
    <asp:ValidationSummary ID="ValidationSummary3" CssClass="alert alert-danger" ValidationGroup="val1" runat="server" />
    <h3><strong class="text-info">EMPLOYEE’s ISOLATION MONITORING REPORT</strong></h3>
    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
        <ContentTemplate>


            <asp:LinkButton ID="btnaddnewrecord" CssClass="btn btn-primary" runat="server" OnClick="btnaddnewrecord_Click">add new record</asp:LinkButton>
            <asp:Panel ID="Panel1" Visible="false" runat="server">
                <div class="container">
                    <blockquote>
                        Time Record (H:M)<br />
                        <asp:TextBox ID="tboxtimerecord" TextMode="Time" CssClass="form-control" runat="server"></asp:TextBox><br />
                        Body Temp (˚C)<br />
                        <asp:TextBox ID="tboxbodytemp" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RegularExpressionValidator ControlToValidate="tboxbodytemp" ValidationExpression="^\d+([,\.]\d{1,1})?$" ForeColor="Red"
                            ID="RegularExpressionValidator3" runat="server" ValidationGroup="addval" ErrorMessage="temperature must be one decimal place"></asp:RegularExpressionValidator><br />
                        Oxygen Saturation (%)<br />
                        <asp:TextBox ID="tboxoxygensaturation" CssClass="form-control" runat="server"></asp:TextBox><br />
                        Chills (Yes / No)<br />
                        <asp:DropDownList ID="dlchills" CssClass="form-control" runat="server">
                            <asp:ListItem Value="Yes">Yes</asp:ListItem>
                            <asp:ListItem Value="No">No</asp:ListItem>
                        </asp:DropDownList><br />
                        Stomachache (degree: 1 – 10)<br />
                        <asp:DropDownList ID="dlstomachache" CssClass="form-control" runat="server">
                            <asp:ListItem Value="1">1</asp:ListItem>
                            <asp:ListItem Value="1">1</asp:ListItem>
                            <asp:ListItem Value="2">2</asp:ListItem>
                            <asp:ListItem Value="3">3</asp:ListItem>
                            <asp:ListItem Value="4">4</asp:ListItem>
                            <asp:ListItem Value="5">5</asp:ListItem>
                            <asp:ListItem Value="6">6</asp:ListItem>
                            <asp:ListItem Value="7">7</asp:ListItem>
                            <asp:ListItem Value="8">8</asp:ListItem>
                            <asp:ListItem Value="9">9</asp:ListItem>
                            <asp:ListItem Value="10">10</asp:ListItem>
                        </asp:DropDownList>
                        <br />
                        No. Vomiting Episode(s)<br />
                        <asp:TextBox ID="tboxvomiting" TextMode="Number" CssClass="form-control" runat="server"></asp:TextBox><br />
                        Bowel Movement (describe stool)<br />
                        <asp:TextBox ID="tboxbowelmovement" CssClass="form-control" runat="server"></asp:TextBox><br />
                        <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="addval" runat="server" />
                        <asp:Button ID="Button1" ValidationGroup="addval" CssClass="btn btn-primary" runat="server" Text="add" OnClick="Button1_Click" />
                        <asp:Button ID="canceladdbtn" CssClass="btn btn-default" runat="server" Text="cancel" OnClick="Button3_Click" />
                    </blockquote>
                </div>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:Panel ID="Panel2" runat="server" ScrollBars="Auto">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>


                <asp:GridView ID="GridView1" CssClass="table text-center" AutoGenerateColumns="false" runat="server" AllowPaging="True" OnRowCommand="GridView1_RowCommand">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="btnedit" CommandName="myedit" runat="server">Edit</asp:LinkButton>
                                <asp:LinkButton ID="btndelete" CommandName="mydelete" OnClientClick="return confirm('delete this record?')" runat="server">Delete</asp:LinkButton>
                                <asp:LinkButton ID="btnupdate" Visible="false" ValidationGroup="editval" CommandName="myupdate" runat="server">Update</asp:LinkButton>
                                <asp:LinkButton ID="btncancel" Visible="false" CommandName="mycancel" runat="server">Cancel</asp:LinkButton>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:LinkButton ID="btninsert" ValidationGroup="insertval" CommandName="myinsert" runat="server">Insert</asp:LinkButton>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-CssClass="text-center" HeaderText="Time Record </br> H:M">
                            <ItemTemplate>
                                <asp:Label ID="lblid" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                <asp:Label ID="lbltimerecord" runat="server" Text='<%# Bind("TIMERECORD") %>'></asp:Label>
                                <asp:TextBox ID="tboxedittimerecord" Visible="false" Text='<%# Bind("TIMERECORD") %>' TextMode="Time" CssClass="form-control" runat="server"></asp:TextBox>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="tboxinserttimerecord" TextMode="Time" CssClass="form-control" runat="server"></asp:TextBox>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-CssClass="text-center" HeaderText="Body Temperature </br> (˚C)">
                            <ItemTemplate>
                                <asp:Label ID="lblbodytemp" runat="server" Text='<%# Bind("BODYTEMP") %>'></asp:Label>
                                <asp:TextBox ID="tboxeditbodytemp" Visible="false" Text='<%# Bind("BODYTEMP") %>' CssClass="form-control" runat="server"></asp:TextBox>
                                <asp:RegularExpressionValidator ControlToValidate="tboxeditbodytemp" Visible="false" ValidationExpression="^\d+([,\.]\d{1,1})?$" ForeColor="Red"
                                    ID="RegularExpressionValidator33" runat="server" ValidationGroup="editval" ErrorMessage="temperature must be one decimal place"></asp:RegularExpressionValidator>
                            </ItemTemplate>
                            <FooterTemplate>
                                <footer></footer>
                                <asp:TextBox ID="tboxinsertbodytemp" CssClass="form-control" runat="server"></asp:TextBox>
                                <asp:RegularExpressionValidator ControlToValidate="tboxinsertbodytemp" ValidationExpression="^\d+([,\.]\d{1,1})?$" ForeColor="Red"
                                    ID="RegularExpressionValidator333" runat="server" ValidationGroup="insertval" ErrorMessage="temperature must be one decimal place"></asp:RegularExpressionValidator>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-CssClass="text-center" HeaderText="Oxygen<br> Saturation (%)">
                            <ItemTemplate>
                                <asp:Label ID="lbloxygensaturation" runat="server" Text='<%# Bind("OXYGENSATURATION") %>'></asp:Label>
                                <asp:TextBox ID="tboxeditoxygensaturation" Visible="false" Text='<%# Bind("OXYGENSATURATION") %>' CssClass="form-control" runat="server"></asp:TextBox>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="tboxinsertoxygensaturation" CssClass="form-control" runat="server"></asp:TextBox>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-CssClass="text-center" HeaderText="Chills (Yes/No)">
                            <ItemTemplate>
                                <asp:Label ID="lblchills" runat="server" Text='<%# Bind("CHILLS") %>'></asp:Label>
                                <asp:DropDownList ID="dleditchills" Visible="false" Text='<%# Bind("CHILLS") %>' CssClass="form-control" runat="server">
                                    <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                    <asp:ListItem Value="No">No</asp:ListItem>
                                </asp:DropDownList>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:DropDownList ID="dlinsertchills" CssClass="form-control" runat="server">
                                    <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                    <asp:ListItem Value="No">No</asp:ListItem>
                                </asp:DropDownList>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-CssClass="text-center" HeaderText="Stomachache<br> (degree: 1 – 10)">
                            <ItemTemplate>
                                <asp:Label ID="lblstomachache" runat="server" Text='<%# Bind("STOMACHACHE") %>'></asp:Label>
                                <asp:DropDownList ID="dleditstomachache" Visible="false" Text='<%# Bind("STOMACHACHE") %>' CssClass="form-control" runat="server">
                                    <asp:ListItem Value="1">1</asp:ListItem>
                                    <asp:ListItem Value="1">1</asp:ListItem>
                                    <asp:ListItem Value="2">2</asp:ListItem>
                                    <asp:ListItem Value="3">3</asp:ListItem>
                                    <asp:ListItem Value="4">4</asp:ListItem>
                                    <asp:ListItem Value="5">5</asp:ListItem>
                                    <asp:ListItem Value="6">6</asp:ListItem>
                                    <asp:ListItem Value="7">7</asp:ListItem>
                                    <asp:ListItem Value="8">8</asp:ListItem>
                                    <asp:ListItem Value="9">9</asp:ListItem>
                                    <asp:ListItem Value="10">10</asp:ListItem>
                                </asp:DropDownList>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:DropDownList ID="dlinsertstomachache" CssClass="form-control" runat="server">
                                    <asp:ListItem Value="1">1</asp:ListItem>
                                    <asp:ListItem Value="1">1</asp:ListItem>
                                    <asp:ListItem Value="2">2</asp:ListItem>
                                    <asp:ListItem Value="3">3</asp:ListItem>
                                    <asp:ListItem Value="4">4</asp:ListItem>
                                    <asp:ListItem Value="5">5</asp:ListItem>
                                    <asp:ListItem Value="6">6</asp:ListItem>
                                    <asp:ListItem Value="7">7</asp:ListItem>
                                    <asp:ListItem Value="8">8</asp:ListItem>
                                    <asp:ListItem Value="9">9</asp:ListItem>
                                    <asp:ListItem Value="10">10</asp:ListItem>
                                </asp:DropDownList>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-CssClass="text-center" HeaderText="No. Vomiting </br> Episode(s)">
                            <ItemTemplate>
                                <asp:Label ID="lblvomiting" runat="server" Text='<%# Bind("VOMITINGEPISODE") %>'></asp:Label>
                                <asp:TextBox ID="tboxeditvomiting" Visible="false" TextMode="Number" Text='<%# Bind("VOMITINGEPISODE") %>' CssClass="form-control" runat="server"></asp:TextBox>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="tboxinsertvomiting" TextMode="Number" CssClass="form-control" runat="server"></asp:TextBox>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-CssClass="text-center" HeaderText="Bowel Movement</br>(describe stool)">
                            <ItemTemplate>
                                <asp:Label ID="lblbowelmovement" runat="server" Text='<%# Bind("BOWELMOVEMENT") %>'></asp:Label>
                                <asp:TextBox ID="tboxeditbowelmovement" Visible="false" Text='<%# Bind("BOWELMOVEMENT") %>' CssClass="form-control" runat="server"></asp:TextBox>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="tboxdeletebowelmovement" CssClass="form-control" runat="server"></asp:TextBox>
                            </FooterTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle Wrap="False" />
                    <RowStyle Wrap="False" />
                    <EmptyDataTemplate>
                        <div class="alert alert-danger">
                            <h3><strong>Empty data!</strong>
                            </h3>
                        </div>
                    </EmptyDataTemplate>
                    <EditRowStyle BorderStyle="None" BorderWidth="0px" />
                    <PagerSettings PageButtonCount="8" />
                    <PagerStyle CssClass="GridPager" HorizontalAlign="Left" />
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
    </asp:Panel>
    <br />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:ValidationSummary ID="ValidationSummary2" CssClass="alert alert-success" runat="server" />
            <asp:Button ID="Button2" CssClass="btn btn-primary" runat="server" Text="Button" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
