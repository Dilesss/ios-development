import UIKit
import AVFoundation

final class ViewController: UIViewController, AVAudioPlayerDelegate {
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!

    // state: one place, the screen is refreshed from it after every tap
    private let tracks = TrackLibrary.tracks
    private var currentIndex = 0
    private var isPlaying = false

    // stored property, so the player lives as long as the screen
    private var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        try? AVAudioSession.sharedInstance().setCategory(.playback)
        loadTrack(at: currentIndex)
        updateUI()
    }

    // MARK: - Actions

    @IBAction func previousTapped(_ sender: UIButton) {
        changeTrack(by: -1)
    }

    @IBAction func playPauseTapped(_ sender: UIButton) {
        guard let player = player else {
            print("Nothing to play: the file for this track could not be loaded")
            return
        }
        if isPlaying {
            player.pause()
        } else {
            player.play()
        }
        isPlaying.toggle()
        updateUI()
    }

    @IBAction func nextTapped(_ sender: UIButton) {
        changeTrack(by: 1)
    }

    // MARK: - Player

    private func changeTrack(by step: Int) {
        guard tracks.isEmpty == false else { return }
        // wrap around: -1 from the first goes to the last, +1 from the last goes to the first
        currentIndex = (currentIndex + step + tracks.count) % tracks.count
        loadTrack(at: currentIndex)

        if isPlaying {
            if let player = player {
                player.play()
            } else {
                isPlaying = false
            }
        }
        updateUI()
    }

    private func loadTrack(at index: Int) {
        player?.stop()
        player = nil

        let track = tracks[index]
        guard let url = Bundle.main.url(forResource: track.fileName, withExtension: nil) else {
            print("File not found in bundle: \(track.fileName). Check Target Membership.")
            return
        }

        do {
            let newPlayer = try AVAudioPlayer(contentsOf: url)
            newPlayer.delegate = self
            newPlayer.prepareToPlay()
            player = newPlayer
        } catch {
            print("Could not play \(track.fileName): \(error.localizedDescription)")
        }
    }

    private func updateUI() {
        let track = tracks[currentIndex]
        coverImageView.image = UIImage(named: track.coverImageName)
        titleLabel.text = track.title
        artistLabel.text = track.artist

        let icon = UIImage(systemName: isPlaying ? "pause.fill" : "play.fill")
        if playPauseButton.configuration != nil {
            playPauseButton.configuration?.image = icon
        } else {
            playPauseButton.setImage(icon, for: .normal)
        }
    }

    // MARK: - AVAudioPlayerDelegate

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        // isPlaying is still true, so the next track starts by itself
        changeTrack(by: 1)
    }
}
