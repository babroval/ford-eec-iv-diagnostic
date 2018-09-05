package babroval.eec_iv.view;

import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;

public class StartView extends JFrame{

	private static final long serialVersionUID = 1L;

	private JPanel panel;
	private JButton errors, koeo, data, disconnect;
	private JCheckBox baud;
	private JLabel label;
	
	{
		panel = new JPanel();
		errors = new JButton("ERRORS");
		koeo = new JButton("KOEO/ER");
		data = new JButton("DATA");
		disconnect = new JButton("Disconnect");
		baud = new JCheckBox("19200");
		label = new JLabel("_");
		
		panel.add(errors);
		panel.add(koeo);
		panel.add(data);
		panel.add(disconnect);
		panel.add(baud);
		panel.add(label);
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

	public JButton getErrors() {
		return errors;
	}

	public void setErrors(JButton errors) {
		this.errors = errors;
	}

	public JButton getKoeo() {
		return koeo;
	}

	public void setKoeo(JButton koeo) {
		this.koeo = koeo;
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
}
