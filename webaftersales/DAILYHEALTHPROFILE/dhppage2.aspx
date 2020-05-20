<%@ Page Language="C#" MasterPageFile="~/DAILYHEALTHPROFILE/DHPmaster.Master" AutoEventWireup="true" CodeBehind="dhppage2.aspx.cs" Inherits="webaftersales.DAILYHEALTHPROFILE.dhppage2" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Daily Health Profile</title>
</asp:Content>

<asp:Content ID="content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <div class="well">
        <h3><strong>Page 2</strong></h3>
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
    <h4>(To be used when a sudden feeling/sensation or symptom is exhibited during working hours – before and during isolation as the case may be)</h4>
    <h3><strong>CONCISE CLINICAL HISTORY</strong></h3>

    <strong>Travel History/Record:</strong>&nbsp;<label class="text-success">(please indicate previous day’s sequence of movement)</label>
    <div class="container">
        <blockquote>
            <asp:CheckBoxList ID="cboxTRAVELHISTORY" runat="server">
                <asp:ListItem Value="home">home</asp:ListItem>
                <asp:ListItem Value="school">school</asp:ListItem>
                <asp:ListItem Value="work">work</asp:ListItem>
                <asp:ListItem Value="drugstore">drugstore</asp:ListItem>
                <asp:ListItem Value="hospital / clinic">hospital / clinic</asp:ListItem>
                <asp:ListItem Value="wet market">wet market</asp:ListItem>
                <asp:ListItem Value="grocery store">grocery store</asp:ListItem>
                <asp:ListItem Value="gym">gym</asp:ListItem>
                <asp:ListItem Value="church">church</asp:ListItem>
            </asp:CheckBoxList>
            <div class="input-group">
                <div class="input-group-addon">Others</div>
                <asp:TextBox ID="tboxother" CssClass="form-control" runat="server"></asp:TextBox>
            </div>

        </blockquote>
    </div>
    <strong>Possible Exposure to Virus:</strong>&nbsp;<label class="text-success">(Please record possible incident where the patient/ employee could’ve contracted the virus)</label>
    <asp:TextBox ID="tboxexposuretovirus" CssClass="form-control" TextMode="MultiLine" Rows="10" runat="server"></asp:TextBox>
    <h3>
        <label style="text-decoration: underline">TEST RESULTS (if applicable)</label></h3>
    <div class="row">
        <div class="col-sm-6">
            DATE OF TEST DONE
            <asp:TextBox ID="tboxdatetestdone" TextMode="Date" runat="server"></asp:TextBox>
            <div class="container">
                <blockquote>
                    <asp:CheckBoxList ID="cboxTESTRESULT" runat="server">
                        <asp:ListItem Value="Negative">Negative</asp:ListItem>
                        <asp:ListItem Value="IgM POSITIVE">IgM POSITIVE</asp:ListItem>
                        <asp:ListItem Value="IgG POSITIVE">IgG POSITIVE</asp:ListItem>
                    </asp:CheckBoxList>
                </blockquote>
            </div>
            Patient Name:<asp:TextBox ID="tboxpatientname" CssClass="form-control" runat="server"></asp:TextBox><br />
            Signature:
            <asp:Image ID="Image1" CssClass="thumbnail" Width="200" Height="200" runat="server" /><br />
        </div>
        <div class="col-sm-6">
            Please attach photo of test result:
          <asp:Image ID="Image2" CssClass="thumbnail" Width="300" Height="300" runat="server" />
            Confirming Physician:
            <asp:TextBox CssClass="form-control" ID="tboxphysician" runat="server"></asp:TextBox><br />
            Affirmed/Witnessed by:
            <asp:TextBox CssClass="form-control" ID="tboxaffirmedwitness" runat="server"></asp:TextBox>
        </div>
    </div>
    <h3><strong>Possible Recommendation(s) after Isolation (if applicable)</strong> </h3>
    <div class="container">
        <blockquote>
            <asp:CheckBox ID="cboxrecoendo" Text="Endorse to respective LGU : " runat="server" /><asp:TextBox ID="tboxrecoendo" CssClass="form-control" runat="server"></asp:TextBox><br />
            <asp:CheckBox ID="cboxrecocallin" Text="Call in for medical Attention and / or endorsement to hospital specify:" runat="server" /><asp:TextBox ID="tboxrecocallin" CssClass="form-control" runat="server"></asp:TextBox><br />
            <asp:CheckBox ID="cboxrecosendhome" Text="Send home" runat="server" /><br />
            <asp:CheckBox ID="cboxrecoother" Text="Others:" runat="server" /><asp:TextBox ID="tboxrecoother" CssClass="form-control" runat="server"></asp:TextBox><br />
        </blockquote>
    </div>
    <asp:LinkButton ID="LinkButton2" CssClass="btn btn-primary" runat="server" OnClick="LinkButton2_Click">SAVE PAGE 2</asp:LinkButton>

</asp:Content>
