package babroval.eec_iv.view;

import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;

public class StartView extends JFrame {

	private static final long serialVersionUID = 1L;

	private JPanel panel;
	private JButton faults, koeo, koer, data, disconnect;
	private JCheckBox baud;
	private JLabel label;
	private JLabel labelConnect;

	{
		panel = new JPanel(null);
		faults = new JButton("FAULTS");
		koeo = new JButton("KOEO");
		koer = new JButton("KOER");
		data = new JButton("DATA");
		disconnect = new JButton("Disconnect");
		baud = new JCheckBox("other ECU");
		label = new JLabel("");
		labelConnect = new JLabel("");

		faults.setBounds(20, 10, 160, 40);
		koeo.setBounds(200, 10, 80, 40);
		koer.setBounds(285, 10, 80, 40);
		data.setBounds(385, 10, 160, 40);
		disconnect.setBounds(680, 10, 160, 40);
		baud.setBounds(860, 10, 160, 20);
		label.setBounds(20, 120, 900, 200);
		labelConnect.setBounds(20, 500, 900, 20);

		panel.add(faults);
		panel.add(koeo);
		panel.add(koer);
		panel.add(data);
		panel.add(disconnect);
		panel.add(baud);
		panel.add(label);
		panel.add(labelConnect);
		add(panel);
	}

	public StartView() {
		setSize(995, 550);
		setTitle("EEC-IV Diagnostic");
		setLocationRelativeTo(null);
		setDefaultCloseOperation(EXIT_ON_CLOSE);
		setResizable(false);
		setVisible(true);
	}

	public JPanel getPanel() {
		return panel;
	}

	public void setPanel(JPanel panel) {
		this.panel = panel;
	}

	public JButton getFaults() {
		return faults;
	}

	public void setFaults(JButton faults) {
		this.faults = faults;
	}

	public JButton getKoeo() {
		return koeo;
	}

	public void setKoeo(JButton koeo) {
		this.koeo = koeo;
	}

	public JButton getKoer() {
		return koer;
	}

	public void setKoer(JButton koer) {
		this.koer = koer;
	}

	public JButton getData() {
		return data;
	}

	public void setData(JButton data) {
		this.data = data;
	}

	public JButton getDisconnect() {
		return disconnect;
	}

	public void setDisconnect(JButton disconnect) {
		this.disconnect = disconnect;
	}

	public JCheckBox getBaud() {
		return baud;
	}

	public void setBaud(JCheckBox baud) {
		this.baud = baud;
	}

	public JLabel getLabel() {
		return label;
	}

	public void setLabel(JLabel label) {
		this.label = label;
	}

	public JLabel getLabelConnect() {
		return labelConnect;
	}

	public void setLabelConnect(JLabel labelConnect) {
		this.labelConnect = labelConnect;
	}

}
