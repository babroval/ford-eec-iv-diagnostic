package babroval.eec_iv.controller;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import javax.swing.JOptionPane;

import babroval.eec_iv.model.Fault;
import babroval.eec_iv.model.Parameter;
import babroval.eec_iv.service.FaultServiceImpl;
import babroval.eec_iv.service.ParameterServiceImpl;
import babroval.eec_iv.service.Service;
import babroval.eec_iv.util.ConnectionPool;
import babroval.eec_iv.view.StartView;
import jssc.SerialPort;
import jssc.SerialPortEvent;
import jssc.SerialPortEventListener;
import jssc.SerialPortException;

public class StartController extends Thread {

	private static final String FILE_FAULTS_PATH = "/EECIVFaults.csv";
	private static final String FILE_PARAMETERS_PATH = "/EECIVParameters.csv";
	private static SerialPort serialPort;
	public static StartView view = new StartView();

	private static List<Fault> allFaults = new ArrayList<>();
	private static List<Parameter> allParameters = new ArrayList<>();
	private static List<String> faults = new ArrayList<>();
	private static StringBuffer data = new StringBuffer("");

	private static Service<Fault> faultService = new FaultServiceImpl();
	private static Service<Parameter> parameterService = new ParameterServiceImpl();

	private static Timer timer = new Timer();
	{
		try {
			serialPort = ConnectionPool.getPool().getPort();
		} catch (Exception e) {
			resetFrame();
		}
		resetFrame();

		try {
			InputStream csvFile = getClass().getResourceAsStream(FILE_FAULTS_PATH);
			allFaults = faultService.getAll(csvFile);
			csvFile = getClass().getResourceAsStream(FILE_PARAMETERS_PATH);
			allParameters = parameterService.getAll(csvFile);
		} catch (Exception e) {
			resetFrame();
			JOptionPane.showMessageDialog(view.getPanel(), "CSV file reading fault", "", JOptionPane.ERROR_MESSAGE);
		}
	}

	public StartController() {
	}

	public void initController() {

		view.getDisconnect().addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent arg0) {
				resetFrame();
			}
		});

		view.getFaults().addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent ae) {
				try {
					faults.clear();
					faults.add("ECU faults:");
					view.getFaults().setEnabled(false);
					view.getData().setEnabled(false);
					view.getDisconnect().setEnabled(false);
					view.getBaud().setEnabled(false);
					view.getLabelConnect().setText("Connection established. Reading ECU faults...  Wait 30 seconds");

					serialPort = ConnectionPool.getPool().getConnection();
					serialPort.addEventListener(new PortReader(), SerialPort.MASK_RXCHAR);
					Thread.sleep(1000);

					if (view.getBaud().isSelected()) {
						serialPort.writeByte((byte) 4);
					} else {
						serialPort.writeByte((byte) 5);
					}
					Thread.sleep(500);

					serialPort.writeByte((byte) 1);

					timer = new Timer();
					timer.schedule(new TimerTask() {
						@Override
						public void run() {
							try {
								serialPort.closePort();
								if (view.getLabel().getText().equals("")) {

									resetFrame();
									view.getLabelConnect().setText(
											"ECU connection fault (check the wiring, reconnect USB cable, select or deselect checkbox 'other ECU', switch the ignition OFF and ON");
									JOptionPane.showMessageDialog(view.getPanel(),
											"ECU connection fault (check the wiring, reconnect USB cable, select or deselect checkbox 'other ECU', switch the ignition OFF and ON",
											"", JOptionPane.WARNING_MESSAGE);
								} else {
									view.getFaults().setEnabled(false);
									view.getKoeo().setEnabled(true);
									view.getDisconnect().setEnabled(true);
									view.getLabel().setVisible(true);
									view.getLabelConnect()
											.setText("Switch the ignition ON, if it is OFF, and press button 'KOEO'");
								}
							} catch (SerialPortException e) {
								resetFrame();
							}
						}
					}, 25000);
				} catch (Exception e) {
					resetFrame();
					JOptionPane.showMessageDialog(view.getPanel(), "COM-port connection fault (check USB wiring)", "",
							JOptionPane.ERROR_MESSAGE);
				}
			}
		});

		view.getKoeo().addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent ae) {
				try {
					faults.clear();
					faults.add("KOEO test result faults:");
					view.getLabel().setText("");
					view.getLabel().setVisible(false);
					view.getFaults().setEnabled(false);
					view.getKoeo().setEnabled(false);
					view.getDisconnect().setEnabled(false);
					view.getBaud().setEnabled(false);
					view.getLabelConnect().setText("Connection established. Performing KOEO test...  Wait 1 minute");

					serialPort = ConnectionPool.getPool().getConnection();
					serialPort.addEventListener(new PortReader(), SerialPort.MASK_RXCHAR);
					Thread.sleep(1000);

					if (view.getBaud().isSelected()) {
						serialPort.writeByte((byte) 4);
					} else {
						serialPort.writeByte((byte) 5);
					}
					Thread.sleep(500);

					serialPort.writeByte((byte) 2);

					timer = new Timer();
					timer.schedule(new TimerTask() {
						@Override
						public void run() {
							try {
								serialPort.closePort();

								if (view.getLabel().getText().equals("")) {
									resetFrame();
									JOptionPane.showMessageDialog(view.getPanel(),
											"ECU connection fault (check wiring and switch the ignition ON)", "",
											JOptionPane.ERROR_MESSAGE);
								} else {
									view.getKoer().setEnabled(true);
									view.getDisconnect().setEnabled(true);
									view.getLabel().setVisible(true);
									view.getLabelConnect().setText("Start the engine and press button 'KOER'");
								}
							} catch (Exception e) {
								resetFrame();
							}
						}
					}, 60000);

				} catch (Exception e) {
					resetFrame();
					JOptionPane.showMessageDialog(view.getPanel(), "COM-port connection fault (check USB wiring)", "",
							JOptionPane.ERROR_MESSAGE);
				}
			}
		});

		view.getKoer().addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent ae) {
				try {
					faults.clear();
					faults.add("KOER test result faults:");
					view.getLabel().setText("");
					view.getLabel().setVisible(false);
					view.getKoer().setEnabled(false);
					view.getDisconnect().setEnabled(false);
					view.getBaud().setEnabled(false);
					view.getLabelConnect().setText("Connection established. Performing KOER test...  Wait 2 minutes");

					serialPort = ConnectionPool.getPool().getConnection();
					serialPort.addEventListener(new PortReader(), SerialPort.MASK_RXCHAR);
					Thread.sleep(1000);

					if (view.getBaud().isSelected()) {
						serialPort.writeByte((byte) 4);
					} else {
						serialPort.writeByte((byte) 5);
					}
					Thread.sleep(500);

					serialPort.writeByte((byte) 2);

					timer = new Timer();
					timer.schedule(new TimerTask() {
						@Override
						public void run() {
							view.getLabelConnect().setText("Performing KOER test... Press and release the brake pedal,"
									+ " turn steering wheel one-half turn,"
									+ " cycle the Overdrive Cancel Switch On and Off, if equipped and wait 1 minute");
						}
					}, 35000);

					timer.schedule(new TimerTask() {
						@Override
						public void run() {
							try {
								serialPort.closePort();

								if (view.getLabel().getText().equals("")) {
									resetFrame();
									JOptionPane.showMessageDialog(view.getPanel(),
											"ECU connection fault (check the wiring and switch the ignition ON)", "",
											JOptionPane.ERROR_MESSAGE);
								} else {
									view.getDisconnect().setEnabled(true);
									view.getData().setEnabled(true);
									view.getLabel().setVisible(true);
									view.getLabelConnect()
											.setText("Start the engine, if it is OFF, and press button 'DATA'");
								}
							} catch (SerialPortException e) {
								resetFrame();
							}
						}
					}, 110000);

				} catch (Exception e) {
					resetFrame();
					JOptionPane.showMessageDialog(view.getPanel(), "COM-port connection fault (check USB wiring)", "",
							JOptionPane.ERROR_MESSAGE);
				}
			}
		});

		view.getData().addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent ae) {
				try {
					faults.clear();
					data.setLength(0);
					view.getLabel().setText("Live Data:");
					view.getLabel().setVisible(false);
					view.getFaults().setEnabled(false);
					view.getKoeo().setEnabled(false);
					view.getKoer().setEnabled(false);
					view.getData().setEnabled(false);
					view.getDisconnect().setEnabled(false);
					view.getBaud().setEnabled(false);
					view.getDataList().setVisible(false);
					view.getLabelConnect().setText("Connection established. Waiting for ECU live data...");

					serialPort = ConnectionPool.getPool().getConnection();
					serialPort.addEventListener(new PortReader(), SerialPort.MASK_RXCHAR);
					Thread.sleep(1000);

					if (view.getBaud().isSelected()) {
						serialPort.writeByte((byte) 4);
					} else {
						serialPort.writeByte((byte) 5);
					}
					Thread.sleep(500);

					serialPort.writeByte((byte) 3);

					timer = new Timer();
					timer.schedule(new TimerTask() {
						@Override
						public void run() {

							if (0 == view.getDataList().getModel().getSize()) {
								resetFrame();
								JOptionPane.showMessageDialog(view.getPanel(),
										"ECU connection fault (check the wiring and switch the ignition ON)", "",
										JOptionPane.ERROR_MESSAGE);
							} else {
								view.getDisconnect().setEnabled(true);
								view.getLabel().setVisible(true);
								view.getDataList().setVisible(true);
								view.getLabelConnect().setText("Connection established. Reading ECU live data...");
							}
						}
					}, 25000);

				} catch (Exception e) {
					resetFrame();
					JOptionPane.showMessageDialog(view.getPanel(), "COM-port connection fault (check USB wiring)", "",
							JOptionPane.ERROR_MESSAGE);
				}
			}
		});
	}

	private static void resetFrame() {
		try {
			if (serialPort.isOpened()) {
				serialPort.closePort();
			}
		} catch (Exception e) {
			view.dispose();
			JOptionPane.showMessageDialog(view.getPanel(),
					"COM-port connection fault (check USB wiring and restart application)", "",
					JOptionPane.ERROR_MESSAGE);

			System.exit(1);
		}
		faults.clear();
		data.setLength(0);
		view.getBaud().setEnabled(true);
		view.getFaults().setEnabled(true);
		view.getKoeo().setEnabled(false);
		view.getKoer().setEnabled(false);
		view.getData().setEnabled(true);
		view.getDisconnect().setEnabled(false);
		view.getLabel().setText("");
		view.getLabel().setVisible(false);
		view.getDataList().setVisible(false);
		view.getLabelConnect().setText("Connect scanner, switch the ignition ON and press button 'FAULTS'");
	}

	private static class PortReader implements SerialPortEventListener {
		@Override
		public void serialEvent(SerialPortEvent event) {
			if (event.isRXCHAR() && event.getEventValue() > 0) {
				try {
					String receivedData = serialPort.readHexString(event.getEventValue());
//					System.out.println(receivedData);
					if (receivedData.equals("19 A1")) {
						timer.cancel();
						resetFrame();
						JOptionPane.showMessageDialog(view.getPanel(),
								"ECU connection fault (check the wiring and switch the ignition ON)", "",
								JOptionPane.ERROR_MESSAGE);
					} else if (faults.isEmpty()) {
						data.append(receivedData.replaceAll("\\s", ""));

						if (64 == data.length()) {
							allParameters = parameterService.updateAll(allParameters, data);
							for (Parameter parameter : allParameters) {
								view.getModelParam().add(parameter.getParameter_id() - 1,
										parameter.getName() + parameter.getValue());
							}
							data.setLength(0);
						}
					} else {
						String faultNumber = receivedData.substring(4, 5) + receivedData.substring(0, 2);

						for (Fault fault : allFaults) {
							if (faultNumber.equals(fault.getNumber())) {
								faults.add(faultNumber + "  " + fault.getInfo());
							}
						}
						String str = "<html>";
						for (String fault : faults) {
							str = str + fault + "<br>";
						}
						view.getLabel().setText(str);
					}
				} catch (Exception e) {
					resetFrame();
					JOptionPane.showMessageDialog(view.getPanel(), "COM-port fault (check connection)" + e, "",
							JOptionPane.ERROR_MESSAGE);
				}
			}
		}
	}
}
