<%@ Page Language="C#" MasterPageFile="~/DAILYHEALTHPROFILE/DHPmaster.Master" AutoEventWireup="true" CodeBehind="dhpnew.aspx.cs" Inherits="webaftersales.DAILYHEALTHPROFILE.dhpnew" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>NEW DHP</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>NEW DHP</strong></h3>
    </div>

    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
    <br />
    <div class="row">
        <div class="col-6-sm">
        </div>
        <div class="col-6-sm">
        </div>
    </div>
    <div class="panel">
        <table border="0">
            <tr>
                <td colspan="2">
                    <h4>KMDI EMPLOYEE DAILY HEALTH PROFILE</h4>
                </td>
            </tr>
            <tr>
                <td>RECORD DATE:
                </td>
                <td>
                    <asp:TextBox ID="TextBox1" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td></td>
            </tr>
            <tr>
                <td>NAME
                </td>
                <td>
                    <asp:Label ID="lblname" runat="server" Text="Label"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>EMPLOYEE NO.
                </td>
                <td>
                    <asp:Label ID="lblempno" runat="server" Text="Label"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>BIRTHDATE
                </td>
                <td>
                    <asp:Label ID="lblbirthday" runat="server" Text="Label"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>AGE
                </td>
                <td>
                    <asp:Label ID="lblage" runat="server" Text="Label"></asp:Label>
                </td>
            </tr>
        </table>
        <br />
        <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
            <table class="table" border="1" style="white-space: nowrap;">
                <tr>
                    <th>Time of Day
                    </th>
                    <th>Actual Time Taken
                    </th>
                    <th>Temperature Reading (˚C)
                    </th>
                </tr>
                <tr>
                    <td>Morning (upon arrival at work)</td>
                    <td>
                        <asp:TextBox ID="tboxmoatt" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxmotr" CssClass="form-control" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Midday (while at work)</td>
                    <td>
                        <asp:TextBox ID="tboxmiatt" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxmitr" CssClass="form-control" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Afternoon (while at work)</td>
                    <td>
                        <asp:TextBox ID="tboxafatt" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxaftr" CssClass="form-control" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Afternoon / Evening (before leaving work)</td>
                    <td>
                        <asp:TextBox ID="tboxevatt" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxevtr" CssClass="form-control" runat="server"></asp:TextBox></td>
                </tr>
            </table>
            <br />
            <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" />
        </asp:Panel>
        <br />
        <asp:Panel ID="Panel2" runat="server" ScrollBars="Auto">
            <table border="0" style="white-space: nowrap;" class="table text-center">
                <tr>
                    <td>
                        <strong>SIGN/SYMPTOM</strong>
                        <br />
                        <small class="text-danger">(Senyales/Sintomas)</small>
                    </td>
                    <td>
                        <strong>Experienced</strong>
                        <br />
                        <small class="text-danger">(Naranasan)</small>
                    </td>
                    <td>
                        <strong>Date of Onset</strong>
                        <br />
                        <small class="text-danger">(mm/dd/yy</small>
                    </td>
                    <td>
                        <strong>Estimated Time of Onset</strong>
                        <br />
                        <small class="text-danger">(H:M)</small>
                    </td>
                    <td style="width:350px">
                        <strong>REMARKS</strong>
                        <br />
                        <small class="text-danger">(Paglalahad)</small>
                    </td>
                </tr>
                <tr>
                      <td><strong>DRY COUGH</strong><br />
                        <small  class="text-danger">(tuyo o matigas na ubo)</small>
                    </td>
                    <td>
                        <asp:CheckBox ID="cboxDCEX" runat="server" /></td>
                    <td>
                        <asp:TextBox ID="tboxDCDO" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxDCET" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxDCRE" CssClass="form-control" runat="server"></asp:TextBox></td>

                </tr>
                  <tr>
                    <td><strong>FEVER</strong><br />
                        <small  class="text-danger">(lagnat – 37.5˚ o higit pa ↑)</small>
                    </td>
                    <td>
                        <asp:CheckBox ID="cboxFEEX" runat="server" /></td>
                    <td>
                        <asp:TextBox ID="tboxFEDO" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxFEET" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxFERE" CssClass="form-control" runat="server"></asp:TextBox></td>

                </tr>
                 <tr>
                    <td><strong>MUSCLE PAIN</strong><br />
                        <small  class="text-danger">(pananakit ng kalamnan)</small>
                    </td>
                    <td>
                        <asp:CheckBox ID="cboxMPEX" runat="server" /></td>
                    <td>
                        <asp:TextBox ID="tboxMPDO" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxMPET" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxMPRE" CssClass="form-control" runat="server"></asp:TextBox></td>

                </tr>
                 <tr>
                    <td><strong>DECREASED SENSE OF SMELL</strong><br />
                        <small  class="text-danger">(kawalan ng pang-amoy)</small>
                    </td>
                    <td>
                        <asp:CheckBox ID="cboxDSEX" runat="server" /></td>
                    <td>
                        <asp:TextBox ID="tboxDSDO" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxDSET" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxDSRE" CssClass="form-control" runat="server"></asp:TextBox></td>

                </tr>
                   <tr>
                    <td><strong>DECREASED SENSE OF TASTE</strong><br />
                        <small  class="text-danger">(kawalan ng panlasa)</small>
                    </td>
                    <td>
                        <asp:CheckBox ID="cboxDTEX" runat="server" /></td>
                    <td>
                        <asp:TextBox ID="tboxDTDO" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxDTET" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxDTRE" CssClass="form-control" runat="server"></asp:TextBox></td>

                </tr>
                  <tr>
                    <td><strong>DIARRHEA</strong><br />
                        <small  class="text-danger">(pagtatae)</small>
                    </td>
                    <td>
                        <asp:CheckBox ID="cboxDIEX" runat="server" /></td>
                    <td>
                        <asp:TextBox ID="tboxDIDO" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxDIET" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxDIRE" CssClass="form-control" runat="server"></asp:TextBox></td>

                </tr>
                 <tr>
                    <td><strong>DIFFICULTY OF BREATHING</strong><br />
                        <small  class="text-danger">(hirap na paghinga)</small>
                    </td>
                    <td>
                        <asp:CheckBox ID="cboxDBEX" runat="server" /></td>
                    <td>
                        <asp:TextBox ID="tboxDBDO" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxDBET" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxDBRE" CssClass="form-control" runat="server"></asp:TextBox></td>

                </tr>
                  <tr>
                    <td><strong>LOOSE BOWEL MOVEMENT</strong><br />
                        <small  class="text-danger">()</small>
                    </td>
                    <td>
                        <asp:CheckBox ID="cboxLBEX" runat="server" /></td>
                    <td>
                        <asp:TextBox ID="tboxLBDO" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxLBET" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxLBRE" CssClass="form-control" runat="server"></asp:TextBox></td>

                </tr>
                   <tr>
                    <td><strong>OTHER SYMPTOM(s)</strong><br />
                        <small  class="text-danger">(Iba pang kakaibang karamdaman)</small>
                    </td>
                    <td>
                        <asp:CheckBox ID="cboxOSEX" runat="server" /></td>
                    <td>
                        <asp:TextBox ID="tboxOSDO" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxOSET" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxOSRE" CssClass="form-control" runat="server"></asp:TextBox></td>

                </tr>
            </table>
            <asp:Button ID="Button2" runat="server" Text="Button" OnClick="Button2_Click" />
        </asp:Panel>
    </div>
</asp:Content>
