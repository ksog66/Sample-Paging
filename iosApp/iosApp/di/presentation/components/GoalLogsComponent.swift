import SwiftUI
import AVKit
import shared
import Kingfisher

struct GoalLogGridComponent: View {
    let data: GoalLog
    @State private var rotation: Double = Double.random(in: -3...3)
    
    var fallback: some View {
        return Image("illustration_waterfall")
            .resizable()
            .aspectRatio(1, contentMode: .fill)
    }
    var body: some View {
        let url = data.type == "VIDEO_LOG" ? (data.preview ?? data.content) : data.content
        VStack(spacing: MsDimensions.dimen8) {
            KFImage.url(URL(string: url))
                .placeholder({fallback})
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: MsDimensions.dimen4))
                .shadow(radius: MsDimensions.dimen4)
            
            MsText(
                text: "#\(data.logCount?.int64Value ?? 0)",
                style: .semibold14.copy(color:Colors.ltGrey)
            )
        }
        .padding(MsDimensions.dimen12)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: MsDimensions.dimen8))
        .shadow(radius: MsDimensions.dimen8)
        .rotationEffect(.degrees(rotation))
        .padding(MsDimensions.dimen8)
    }
}

struct InProgressLogGridComponent: View {
    let data: GoalLog
    @State private var rotation: Double = Double.random(in: -3...3)
    
    var fallback: some View {
        return Image("illustration_waterfall")
            .resizable()
            .aspectRatio(1, contentMode: .fill)
    }
    
    var body: some View {
        let url = data.type == "VIDEO_LOG" ? (data.preview ?? data.content) : data.content
        VStack(spacing: MsDimensions.dimen8) {
            ZStack {
                KFImage.url(URL(string: url))
                    .placeholder({fallback})
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: MsDimensions.dimen4))
                    .shadow(radius: MsDimensions.dimen4)
                
                Color(white: 0.94, opacity: 0.5)
                    .frame(maxWidth: .infinity)
                    .aspectRatio(MsDimensions.dimen2, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: MsDimensions.dimen2))
                
                CircularSpokeLoaderAnimation()
                    .aspectRatio(1, contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: MsDimensions.dimen4))
                    .shadow(radius: MsDimensions.dimen4)
                
            }
            
            MsText(
                text: "#uploading",
                maxLines: 1,
                style: .semibold14.copy(color: Colors.ltGrey)
            )
        }
        .padding(MsDimensions.dimen12)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: MsDimensions.dimen4))
        .shadow(radius: MsDimensions.dimen8)
        .rotationEffect(.degrees(rotation))
        .padding(MsDimensions.dimen8)
    }
}

struct GoalLogMaxCardComponent: View {
    let data: GoalLog
    let canPlay: Bool
    @State private var rotation: Double = Double.random(in: -3...3)
    @State private var player: AVPlayer?
    @State private var isPlaying: Bool = false
    
    var fallback: some View {
        return Image("illustration_waterfall")
            .resizable()
            .aspectRatio(1, contentMode: .fill)
    }
    
    var body: some View {
        VStack {
            ZStack {
                if data.type == "VIDEO_LOG" {
                    VideoPlayer(player: player)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .aspectRatio(1, contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: MsDimensions.dimen8))
                        .shadow(radius: MsDimensions.dimen8)
                        .onTapGesture {
                            if canPlay {
                                if isPlaying {
                                    player?.pause()
                                } else {
                                    player?.play()
                                }
                                isPlaying.toggle()
                            }
                        }
                } else {
                    KFImage.url(URL(string: data.content))
                        .placeholder({fallback})
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: MsDimensions.dimen8))
                        .shadow(radius: MsDimensions.dimen8)
                    
                }
            }
            .frame(maxHeight: .infinity)
            
            VerticalSpace(height: MsDimensions.dimen16)
            
            HStack {
                if let caption = data.caption {
                    MsText(
                        text: LocalizedStringKey(caption),
                        maxLines: 2,
                        style: .semibold16
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Spacer()
                
                MsText(
                    text: "#\(data.logCount?.int64Value ?? -1)",
                    style: .semibold18.copy(color: Colors.ltGrey)
                )
                .frame(maxWidth: data.caption == nil ? .infinity : .none, alignment: .trailing)
            }
            .frame(maxWidth: .infinity)
            
            VerticalSpace(height: MsDimensions.dimen8)
            
            MsText(
                text: LocalizedStringKey(convertAndFormatDate(from: data.dateCreated) ?? ""),
                style: .medium14.copy(color: Colors.ltGrey)
            ).frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(MsDimensions.dimen16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: MsDimensions.dimen12))
        .shadow(radius: MsDimensions.dimen16)
        .rotationEffect(.degrees(rotation))
        .padding(MsDimensions.dimen16)
        .onAppear {
            if data.type == "VIDEO_LOG" {
                player = AVPlayer(url: URL(string: data.content)!)
                if canPlay {
                    player?.play()
                    isPlaying = true
                }
            }
        }
    }
}


struct AddNewLogItem: View {
    let onItemClick: () -> Void
    @State private var rotation: Double = Double.random(in: -3...3)
    
    var body: some View {
        VStack(spacing: MsDimensions.dimen8) {
            ZStack {
                RoundedRectangle(cornerRadius: MsDimensions.dimen4)
                    .fill(Colors.ltGrey.opacity(0.7))
                    .overlay(
                        RoundedRectangle(cornerRadius: MsDimensions.dimen2)
                            .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [4]))
                            .foregroundColor(Colors.blueBlack.opacity(0.8))
                    )
                
                VStack(spacing: MsDimensions.dimen8) {
                    Image(systemName: "camera")
                        .font(.system(size: MsDimensions.dimen24))
                    
                    MsText(
                        text:"Tap to add",
                        style: .medium12
                    )
                }
            }
            .aspectRatio(1, contentMode: .fill)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: MsDimensions.dimen4))
            .shadow(radius: MsDimensions.dimen4)
            
            MsText(
                text:"New Entry",
                maxLines: 1,
                style: .semibold14.copy(color: Colors.ltGrey)
            )
        }
        .padding(MsDimensions.dimen12)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: MsDimensions.dimen8))
        .shadow(radius: MsDimensions.dimen8)
        .rotationEffect(.degrees(rotation))
        .padding(MsDimensions.dimen8)
        .onTapGesture {
            onItemClick()
        }
    }
}

struct CircularSpokeLoaderAnimation: View {
    let barCount: Int = 10
    let barWidthInner: CGFloat = MsDimensions.dimen4
    let barWidthOuter: CGFloat = MsDimensions.dimen12
    let barHeight: CGFloat = MsDimensions.dimen40
    let cornerRadius: CGFloat = MsDimensions.dimen4
    
    @State private var rotation: Double = 0
    
    var body: some View {
        ZStack {
            ForEach(0..<barCount, id: \.self) { index in
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: barWidthInner, height: barHeight)
                    .offset(y: -barHeight/2)
                    .rotationEffect(.degrees(Double(index) * (360.0 / Double(barCount))))
            }
        }
        .rotationEffect(.degrees(rotation))
        .onAppear {
            withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                rotation = 360
            }
        }
    }
}

struct EmptyGoalLogsComponent: View {
    var body: some View {
        VStack {
            ZStack {
                ForEach(0..<3, id: \.self) { index in
                    let xOffset = CGFloat(index) * 8
                    let yOffset = CGFloat(index) * 4
                    let rotationAngle = -5 + CGFloat(index) * 5
                    
                    PlaceholderCard()
                        .offset(x: xOffset, y: yOffset)
                        .rotationEffect(.degrees(rotationAngle))
                }
                
                PlaceholderCard()
                    .offset(x: 16, y: 8)
                    .rotationEffect(.degrees(5))
                    .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
            }
            .padding(16)
        }
        .padding(24)
    }
}

struct PlaceholderCard: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.white)
                .frame(width: 200, height: 160)
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
            
            RoundedRectangle(cornerRadius: 2)
                .strokeBorder(
                    style: StrokeStyle(lineWidth: 2, dash: [4])
                )
                .foregroundColor(Color.gray.opacity(0.5))
                .background(
                    Color.gray.opacity(0.2)
                        .cornerRadius(2)
                )
                .frame(width: 176, height: 144)
                .overlay(
                    Image("student_study")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 176, height: 144)
                        .clipped()
                        .opacity(0.4)
                )
        }
        .padding(12)
    }
}

struct FailedLogGridComponent: View {
    var data: GoalLog
    var retryUpload: (String) -> Void
    
    var body: some View {
        let mediaUrl = data.type == "VIDEO_LOG" ? data.preview : data.content
        let rotation = Double.random(in: -3...3)
        
        VStack(spacing: 12) {
            ZStack {
                KFImage(URL(string: mediaUrl ?? ""))
                    .placeholder {
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .shadow(radius: 4)
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width - 64, height: UIScreen.main.bounds.width - 64)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(radius: 4)
                    .rotationEffect(.degrees(rotation))
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                
                VStack(spacing: 4) {
                    Button(action: { retryUpload(data.id) }) {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 32, height: 32)
                            .overlay(
                                Image(systemName: "arrow.up")
                                    .foregroundColor(.red)
                            )
                    }
                    
                    MsText(text: "Retry", style: .semibold16.copy(color: Colors.white1))
                }
            }
            
            MsText(text: "#Failed to upload", style: .semibold14.copy(color: Colors.ltGrey))
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 12)
    }
}

struct InProgressLogMaxCardComponent: View {
    var data: GoalLog
    
    // Random rotation between -3 and 3 degrees, stable per view
    @State private var rotation: Double = Double.random(in: -3...3)
    
    var body: some View {
        let mediaUrl = data.type == "VIDEO_LOG" ? data.preview : data.content
        
        VStack(spacing: 12) {
            ZStack {
                if let urlString = mediaUrl, let url = URL(string: urlString) {
                    KFImage(url)
                        .resizable()
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .frame(maxWidth: .infinity)
                        .aspectRatio(1, contentMode: .fit)
                        .rotationEffect(.degrees(rotation))
                        .clipped()
                } else {
                    Color.gray
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .frame(maxWidth: .infinity)
                        .aspectRatio(1, contentMode: .fit)
                }
                
                // Overlay with translucent background and loader
                Rectangle()
                    .fill(Color(.sRGBLinear, white: 0.94, opacity: 0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .frame(maxWidth: .infinity)
                    .aspectRatio(1, contentMode: .fit)
                
                // Placeholder for CircularSpokeLoaderAnimation - you can customize this
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                    .scaleEffect(2)
            }
            
            if let caption = data.caption, !caption.isEmpty {
                MsText(text: LocalizedStringKey(caption), style: .semibold14)
                    .padding(.horizontal, 4)
            }
            
            HStack {
                MsText(text: LocalizedStringKey(convertAndFormatDate(from: data.dateCreated) ?? ""), style: .medium10)
                Spacer()
                MsText(text: "#uploading", style: .semibold12.copy(color: Colors.ltGrey))
            }
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 8)
        .padding(16)
    }
}


struct FailedLogMaxCardComponent: View {
    var data: GoalLog
    var retryUpload: (String) -> Void
    
    @State private var rotation: Double = Double.random(in: -3...3)
    
    var body: some View {
        let mediaUrl = data.type == "VIDEO_LOG" ? data.preview : data.content
        
        VStack(spacing: 12) {
            ZStack {
                if let urlString = mediaUrl, let url = URL(string: urlString) {
                    KFImage(url)
                        .resizable()
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .frame(maxWidth: .infinity)
                        .aspectRatio(1, contentMode: .fit)
                        .rotationEffect(.degrees(rotation))
                        .clipped()
                        .shadow(radius: 8)
                } else {
                    Color.gray
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .frame(maxWidth: .infinity)
                        .aspectRatio(1, contentMode: .fit)
                        .shadow(radius: 8)
                }
                
                // Overlay with black translucent background + retry button
                Color.black.opacity(0.6)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .onTapGesture {
                        retryUpload(data.id)
                    }
                
                VStack(spacing: 8) {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 48, height: 48)
                        .overlay(
                            Image(systemName: "arrow.up.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32, height: 32)
                                .foregroundColor(Color.red) // Use your pinkishRed if defined
                                .padding(8)
                        )
                    
                    MsText(text: "retry_literal", style: .semibold14.copy(color: Colors.white1))
                }
            }
            
            if let caption = data.caption, !caption.isEmpty {
                MsText(text: LocalizedStringKey(caption), style: .semibold14)
                    .padding(.horizontal, 4)
                Spacer().frame(height: 8)
            }
            
            HStack {
                MsText(text: "#Failed to upload", style: .semibold18.copy(color: Colors.ltGrey))
                Spacer()
                MsText(
                    text: LocalizedStringKey(convertAndFormatDate(from: data.dateCreated) ?? ""),
                    style: .medium14.copy(color: Colors.ltGrey)
                )
            }
            
            if let caption = data.caption {
                Spacer().frame(height: 8)
                MsText(text: LocalizedStringKey(caption), maxLines: 2, style: .semibold16)
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 16)
        .padding(16)
    }
}




struct EmptyGoalLogsComponent_Previews: PreviewProvider {
    static var previews: some View {
        EmptyGoalLogsComponent()
            .previewLayout(.sizeThatFits)
    }
}


#Preview {
    VStack {
        GoalLogGridComponent(
            data: GoalLog(
                id: "1",
                content: "Started my morning workout.",
                dateCreated: "2025-05-12T06:30:00.000Z",
                goalId: 101,
                type: "IMAGE_LOG",
                userId: 1,
                caption: "Feeling pumped!",
                preview: "https://example.com/images/workout.jpg",
                logCount: 1,
                uploadStatus: "uploaded"
            )
        )
        
        InProgressLogGridComponent(
            data: GoalLog(
                id: "2",
                content: "Completed 30 mins of meditation.",
                dateCreated: "2025-05-12T07:15:00.000Z",
                goalId: 101,
                type: "video",
                userId: 1,
                caption: "Calm and relaxed.",
                preview: "https://example.com/videos/meditation.mp4",
                logCount: 2,
                uploadStatus: "pending"
            )
        )
        
        GoalLogMaxCardComponent(
            data: GoalLog(
                id: "3",
                content: "Finished reading 20 pages of Atomic Habits.",
                dateCreated: "2025-05-12T09:00:00.000Z",
                goalId: 102,
                type: "text",
                userId: 2,
                caption: "Insightful read.",
                preview: nil,
                logCount: 1,
                uploadStatus: "uploaded"
            ),
            canPlay: true
        )
        
        AddNewLogItem {
            print("Add new log tapped")
        }
    }
    .padding()
    .background(Color.gray.opacity(0.1))
}
